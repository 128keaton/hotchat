class RoomsController < ApplicationController
  before_action :set_room, only: %i[  destroy  ]


  def emit_room
    set_room
    update_room_session(@room.id, @session)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("current_room", partial: "messages", locals: { room: @room }) }
      format.html { redirect_to root_path }
    end
  end

  def leave_room
    update_room_session(nil, @session)

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("current_room", partial: "empty") }
      format.html { redirect_to root_path }
    end
  end

  def count_rooms
    render json: {total: Room.all.count}
  end

  def new
    @room = Room.new
  end

  def edit
  end

  def create
    name = "#{room_params[:name]}##{rand.to_s[2..6]}"
    @room = Room.create!(owner_id: @user.id, name: name)

    respond_to do |format|
      format.turbo_stream
      format.html {
        return redirect_to index
      }
    end
  end

  def destroy
    @room.destroy
    update_room_session(nil, @session)

    respond_to do |format|
      format.turbo_stream {
        # render turbo_stream: turbo_stream.replace("current_room", partial: "empty")
      }
      format.html { redirect_to root_path }
    end
  end

  private

  def update_room_session(room_id, session)
    session.room_id = room_id
    session.save
  end

  def set_room
    room_id = params[:id]

    if room_id.nil?
      room_id = params[:room_id]
    end

    begin
      @room = Room.find(room_id)

    rescue
      redirect_to root_path
    end
  end

  def room_params
    params.require(:room).permit(:name)
  end
end
