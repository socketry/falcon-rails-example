require "test_helper"

class OllamaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ollama_index_url
    assert_response :success
  end
end
