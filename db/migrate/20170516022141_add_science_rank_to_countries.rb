class AddScienceRankToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :science_rank, :integer
  end
end
