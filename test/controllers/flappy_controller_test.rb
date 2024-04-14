require "test_helper"

class FlappyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get flappy_index_url
    assert_response :success
  end

  test "should get live" do
    get flappy_live_url
    assert_response :success
  end
end
