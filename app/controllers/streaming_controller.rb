class StreamingController < ApplicationController
  def index
    body = Enumerator.new do |enumerator|
      100.downto(0) do |i|
        enumerator << "#{i} bottles of beer on the wall\n"
        sleep 0.1
        enumerator << "#{i} bottles of beer\n"
        sleep 0.1
        enumerator << "Take one down, pass it around\n"
        sleep 0.1
        enumerator << "#{i - 1} bottles of beer on the wall\n"
        sleep 0.1
      end
    end

    # Works, puma, falcon, Rails 7.1
    self.response = Rack::Response[200, {"content-type" => "text/plain"}, body]
  end
end
