class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:message][:chatroom_id])
    @message = @chatroom.messages.build(message_params)

    if @message.save
      # Broadcast the new message to the chatroom's channel
      ActionCable.server.broadcast "chatroom_#{@chatroom.id}", render_message(@message)
      head :ok
    else
      redirect_to chatroom_path(@chatroom)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :chatroom_id)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: "messages/message", locals: { message: message })
  end
end
