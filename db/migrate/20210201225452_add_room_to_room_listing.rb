class AddRoomToRoomListing < ActiveRecord::Migration[6.1]
  def change
    add_column :room_listings, :room_id, :bigint
  end
end
