class Room < ApplicationRecord
  has_many :messages
  has_many :users, -> { distinct }, through: :messages, dependent: false

  broadcasts

  after_create_commit -> {
    broadcast_action_to('room', action: :replace, target: "room_count", partial: "shared_partials/count", locals: {rooms: Room.all})
    broadcast_append_to :rooms
  }

  after_destroy_commit -> {
    broadcast_action_to('room', action: :replace, target: "current_room", partial: "shared_partials/empty")
    broadcast_action_to('room', action: :replace, target: "room_count", partial: "shared_partials/count", locals: {rooms: Room.all})
    broadcast_remove_to :rooms
  }
end
