class RoomsController < ApplicationController
  before_action :require_session_id
  before_action :set_room, only: %i[ show edit update destroy ]

  def index
    @rooms = Room.all
    render 'list'
  end

  def show
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    @room = Room.create!(name: room_params, owner_id: @user.id)

    respond_to do |format|
      format.turbo_stream
      format.html {
        return redirect_to index
      }
    end
  end

  def destroy
    @room.destroy
    respond_to do |format|
      format.turbo_stream
      format.html {
        return redirect_to root_path
      }
    end
  end

  private

  def set_room
    begin
      @room = Room.find(params[:id])

    rescue
      redirect_to rooms_path
    end
  end

  def room_params
    params.require(:name)
  end

  def require_session_id
    current_user_id = session[:current_user_id]

    begin
      @user = User.find(current_user_id)
    rescue ActiveRecord::RecordNotFound => e
      redirect_to login_path
    end
  end
end
