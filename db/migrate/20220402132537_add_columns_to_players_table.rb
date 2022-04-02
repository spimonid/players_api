class AddColumnsToPlayersTable < ActiveRecord::Migration[6.1]
  def change
    add_column :players, :age, :integer
    add_column :players, :position, :string
    add_column :players, :full_name, :string
    add_column :players, :first_name, :string
    add_column :players, :last_name, :string
    add_column :players, :name_brief, :string
    add_column :players, :average_position_age_diff, :integer
    add_column :players, :sport, :string
  end
end
