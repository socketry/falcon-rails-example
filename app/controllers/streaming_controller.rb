class StreamingController < ApplicationController
  def simple
    body = Enumerator.new do |enumerator|
      enumerator << "." * 1024
      
      100.times do |i|
        enumerator << "This is line #{i}\n"
        sleep 0.1
      end
    end

    # Works, puma, falcon, Rails 7.1
    self.response = Rack::Response[200, {"content-type" => "text/plain"}, body]

    # Should work on Rails 7.2+
    # self.response = ActionDispatch::Response.new(200, {"content-type" => "text/plain"}, body)
    # self.response_body = body
  end
end
