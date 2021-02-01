class AddRoomsToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :rooms, index: true, foreign_key: true
  end
end
