require "test_helper"

class StreamingControllerTest < ActionDispatch::IntegrationTest
  test "should get simple" do
    get streaming_simple_url
    assert_response :success
  end
end
