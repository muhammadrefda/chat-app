class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:message][:chatroom_id])
    @message = @chatroom.messages.build(message_params)

    if @message.save
      respond_to do |format|
        format.html { redirect_to @chatroom } # fallback if no AJAX
        format.js   # for AJAX response
      end
    else
      respond_to do |format|
        format.html { redirect_to @chatroom }
        format.js   # handle error
      end
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
