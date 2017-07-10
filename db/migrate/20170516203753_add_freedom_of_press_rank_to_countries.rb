class AddFreedomOfPressRankToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :freedom_of_press_rank, :integer
  end
end
