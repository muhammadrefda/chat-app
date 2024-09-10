require "test_helper"

class ChatroomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chatrooms_path
    assert_response :success
  end

  test "should get show" do
    chatroom = chatrooms(:one) # Assuming you have a fixture named :one
    get chatroom_path(chatroom)
    assert_response :success
  end
end
