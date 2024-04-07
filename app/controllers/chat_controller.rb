require 'chat'
require 'async/websocket/adapters/rails'

class ChatController < ApplicationController
  def index
  end

  def connect
    channel = params.fetch(:channel, 'chat.general')

    self.response = Async::WebSocket::Adapters::Rails.open(request) do |connection|
      Sync do
        client = Chat::Redis.instance
        subscription_task = Async do
          # Subscribe to the channel and broadcast incoming messages:
          client.subscribe(channel) do |context|
            while true
              type, name, message = context.listen

              # The message is text, but contains JSON.
              connection.send_text(message)
              connection.flush
            end
          end
        end

        # Perpetually read incoming messages and publish them to Redis:
        while message = connection.read
          client.publish(channel, message.buffer)
        end
      rescue Protocol::WebSocket::ClosedError
        # Ignore.
      ensure
        subscription_task&.stop
      end
    end
  end
end
