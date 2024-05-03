class SseController < ApplicationController
	def index
	end

	EVENT_STREAM_HEADERS = {
		'content-type' => 'text/event-stream',
	}

	def events
		# current_user_id = User.last.id
		
		# puts "Connection Pool Stats Stream: #{ActiveRecord::Base.connection_pool.stat}"
		
		body = proc do |stream|
			while true
				Console.info(self, "Sending message...")
				stream.write("data: #{Time.now}\n\n")
				sleep 1
			end
		end
		
		self.response = Rack::Response[200, EVENT_STREAM_HEADERS.dup, body]
	end
end
