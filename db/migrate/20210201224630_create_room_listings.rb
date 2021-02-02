class CreateRoomListings < ActiveRecord::Migration[6.1]
  def change
    create_table :room_listings do |t|
      t.timestamps
    end
  end
end
