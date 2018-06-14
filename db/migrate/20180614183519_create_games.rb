class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :league, foreign_key: true
      t.string :player_1
      t.string :player_2
      t.integer :score_1
      t.integer :score_2
      t.boolean :is_finished

      t.timestamps
    end
  end
end
