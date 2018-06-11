class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.integer :max_contestants

      t.timestamps
    end
  end
end
