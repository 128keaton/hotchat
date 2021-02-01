class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :users, [:id, :name], unique: true
  end
end
