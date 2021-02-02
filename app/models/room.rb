class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages, dependent: false
  belongs_to :owner, class_name: 'User'

  broadcasts
   after_create_commit -> {
     broadcast_append_to :rooms
   }

   after_destroy_commit -> {
     broadcast_remove_to :rooms
     broadcast_remove_to self
   }
end
