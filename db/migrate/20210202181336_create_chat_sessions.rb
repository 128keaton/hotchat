class CreateChatSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_sessions do |t|
      t.bigint :room_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
