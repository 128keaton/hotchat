class User < ApplicationRecord
  has_many :messages, inverse_of: :user
  has_many :rooms, through: :messages
end
