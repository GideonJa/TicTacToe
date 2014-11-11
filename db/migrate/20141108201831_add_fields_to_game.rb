class AddFieldsToGame < ActiveRecord::Migration
  def change
    add_column :games, :board, :text, array: true, default: []
    add_column :games, :current_player, :string
    add_column :games, :moves, :text, array: true, default: []
    add_column :games, :score, :integer
    add_column :games, :level, :integer
    add_column :games, :name, :string
  end
end
