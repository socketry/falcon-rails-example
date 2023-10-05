# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2023, by Samuel Williams.

require 'async/redis'
require 'thread/local'

module Chat
  module Redis
    extend Thread::Local

    def self.local
      endpoint = Async::Redis.local_endpoint
      client = Async::Redis::Client.new(endpoint)
    end
  end
end
