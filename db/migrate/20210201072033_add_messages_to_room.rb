class AddMessagesToRoom < ActiveRecord::Migration[6.1]
  def change
    add_reference :rooms, :messages, index: true
  end
end
