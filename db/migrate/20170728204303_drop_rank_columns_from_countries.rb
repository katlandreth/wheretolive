class DropRankColumnsFromCountries < ActiveRecord::Migration
  def up
    remove_column :countries, :science_rank
    remove_column :countries, :freedom_of_press_rank
    remove_column :countries, :life_satisfaction_rank
    remove_column :countries, :cost_of_living_rank
    remove_column :countries, :math_rank
    remove_column :countries, :reading_rank
  end

  def down
    add_column :countries, :science_rank, :float
    add_column :countries, :freedom_of_press_rank, :float
    add_column :countries, :life_satisfaction_rank, :float
    add_column :countries, :cost_of_living_rank, :float
    add_column :countries, :math_rank, :float
    add_column :countries, :reading_rank, :float
  end
end
