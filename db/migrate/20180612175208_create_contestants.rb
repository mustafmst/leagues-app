class CreateContestants < ActiveRecord::Migration[5.2]
  def change
    create_table :contestants do |t|
      t.references :league, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :points
      t.boolean :has_won

      t.timestamps
    end
  end
end
