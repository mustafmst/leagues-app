class AddFieldsToLeagues < ActiveRecord::Migration[5.2]
  def change
    add_column :leagues, :is_closed, :boolean
    add_column :leagues, :is_finished, :boolean
    add_column :leagues, :games_left, :integer
  end
end
