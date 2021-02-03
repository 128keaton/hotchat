class MessagesController < ApplicationController
  before_action :set_room

  def new
    @message = @room.messages.new
  end

  def create
    unless message_params[:content].to_s.strip.empty?
      content = truncate(message_params[:content], :length => 420)
      @message = @room.messages.create!(content: content, room: @room, user: @user)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
    end
  end

  private

  def set_room
    @room = Room.find(@session.room_id)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
