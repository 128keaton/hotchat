class AddUserToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :user_id, :bigint
    add_column :messages, :room_id, :bigint
  end
end
