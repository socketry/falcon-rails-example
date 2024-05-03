require "test_helper"

class SseControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sse_index_url
    assert_response :success
  end

  test "should get events" do
    get sse_events_url
    assert_response :success
  end
end
