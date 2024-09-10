require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @chatroom = Chatroom.create(name: "General")
  end

  test "should create message" do
    assert_difference 'Message.count', 1 do
      post messages_path, params: { message: { content: "This is a test message", chatroom_id: @chatroom.id } }
    end
    assert_response :success
  end

  test "should not create message without content" do
    assert_no_difference 'Message.count' do
      post messages_path, params: { message: { content: "", chatroom_id: @chatroom.id } }
    end
    assert_response :redirect
  end
end
