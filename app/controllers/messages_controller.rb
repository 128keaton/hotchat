class MessagesController < ApplicationController
  before_action :set_room

  def new
    @message = @room.messages.new
  end

  def create
    unless message_params[:content].to_s.strip.empty?
      @message = @room.messages.create!(content: message_params[:content], room: @room, user: @user)

      respond_to do |format|
        format.turbo_stream {
          return render turbo_stream: turbo_stream.update(@message), locals: { user: @user }
        }
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
