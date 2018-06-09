class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.integer :id

      t.timestamps
    end
    add_index :users, :id, unique: true
  end
end
