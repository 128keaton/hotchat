class AddOwnerToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :owner_id, :bigint
  end
end
