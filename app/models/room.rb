class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages, dependent: false
  broadcasts
end
