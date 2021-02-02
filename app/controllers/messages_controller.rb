class MessagesController < ApplicationController
  before_action :set_room_and_user, only: %i[ new create ]

  def new
    @message = @room.messages.new
  end

  def create
    unless message_params[:content].to_s.strip.empty?

      @message = @room.messages.create!(content: message_params[:content], room: @room, user: @user)
      @user = @user

      respond_to do |format|
        format.turbo_stream {
          return render turbo_stream: turbo_stream.replace(@message), locals: { user: @user }
        }
        format.html { redirect_to @room }
      end
    end
  end

  private

  def set_room_and_user
    current_user_id = session[:current_user_id]

    begin
      @user = User.find(current_user_id)
    rescue ActiveRecord::RecordNotFound => e
      redirect_to login_path
    end

    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
