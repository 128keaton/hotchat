class RoomsController < ApplicationController
  before_action :require_session_id
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
    render 'list'
  end

  def show
    puts @room
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.create!(room_params)
    redirect_to @room, notice: 'Room was successfully created.'
  end

  def update
    @room.update!(room_params)
    redirect_to @room, notice: 'Room was successfully updated.'
  end

  def destroy
    @room.destroy
    redirect_to root_path, notice: 'Room was successfully destroyed.'
  end

  private

  def set_room
    @room = Room.find(params[:id])
    puts @room
  end

  def room_params
    params.require(:room).permit(:name)
  end

  def require_session_id
    current_user_id = session[:current_user_id]

    if current_user_id.nil?
      redirect_to login_path
      return
    end

    @user = User.find(current_user_id)
  end
end
