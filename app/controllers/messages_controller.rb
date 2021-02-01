class MessagesController < ApplicationController
  before_action :require_session_id
  before_action :set_room, only: %i[ new create ]

  def new
    @message = @room.messages.new
  end

  def create
    @message = @room.messages.create!(content: message_params[:content], room: @room, user: @user)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @room }
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def require_session_id
    current_user_id = session[:current_user_id]

    if current_user_id.nil?
      redirect_to login_path
      return
    end

    @user = User.find(current_user_id)
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
