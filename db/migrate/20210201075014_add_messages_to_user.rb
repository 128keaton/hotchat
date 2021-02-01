class AddMessagesToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :messages, foreign_key: true
  end
end
