class MessagesController < ApplicationController
  before_action :set_room

  def new
    @message = @room.messages.new
  end

  def create
    unless message_params[:content].to_s.strip.empty?
      content = truncate(message_params[:content])
      @message = @room.messages.create!(content: content, room: @room, user: @user)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
    end
  end

  private

  def truncate(string, length = 420)
    (string.size > length) ? string[0, length] : string
  end

  def set_room
    @room = Room.find(@session.room_id)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
