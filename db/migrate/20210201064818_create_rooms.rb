class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :rooms, [:id, :name], unique: true
  end
end
