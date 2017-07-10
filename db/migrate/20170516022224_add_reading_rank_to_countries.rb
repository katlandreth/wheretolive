class AddReadingRankToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :reading_rank, :integer
  end
end
