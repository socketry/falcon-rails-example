class SseController < ApplicationController
	def index
	end

	EVENT_STREAM_HEADERS = {
		'content-type' => 'text/event-stream',
	}

	def events
		Highscore.with_connection do
			highscore_id = Highscore.last.id
		end
		
		body = proc do |stream|
			while true
				Console.info(self, "Connection Pool Stat", stats: Highscore.connection_pool.stat)
				stream.write("data: #{Time.now}\n\n")
				sleep 1
			end
		end
		
		self.response = Rack::Response[200, EVENT_STREAM_HEADERS.dup, body]
	end
end
