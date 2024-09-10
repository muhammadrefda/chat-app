require "test_helper"

class MessageTest < ActiveSupport::TestCase
  def setup
    @chatroom = Chatroom.create(name: "General")
    @message = @chatroom.messages.build(content: "Hello, world!")
  end

  test "message should be valid" do
    assert @message.valid?
  end

  test "content should be present" do
    @message.content = " "
    assert_not @message.valid?
  end

  test "message should belong to a chatroom" do
    @message.chatroom = nil
    assert_not @message.valid?
  end
end
