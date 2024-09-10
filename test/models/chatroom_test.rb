require "test_helper"

class ChatroomTest < ActiveSupport::TestCase
  def setup
    @chatroom = Chatroom.new(name: "General")
  end

  test "chatroom should be valid" do
    assert @chatroom.valid?
  end

  test "name should be present" do
    @chatroom.name = " "
    assert_not @chatroom.valid?
  end
end
