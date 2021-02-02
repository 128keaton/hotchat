class User < ApplicationRecord
  before_destroy :destroy_messages

  has_many :messages, inverse_of: :user
  has_many :rooms, through: :messages
  # broadcasts_to :rooms

  after_create_commit -> {
    broadcast_append_to :rooms
    broadcast_append_to self
  }
  after_destroy_commit -> {
    broadcast_remove_to :rooms
    broadcast_remove_to self
  }

  def destroy_messages
    self.messages.destroy_all
  end
end
