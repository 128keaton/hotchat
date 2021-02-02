class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  broadcasts_to :room

  after_destroy_commit -> {
    broadcast_remove_to :rooms
    broadcast_remove_to self
  }
end
