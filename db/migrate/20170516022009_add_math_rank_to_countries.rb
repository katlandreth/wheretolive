class AddMathRankToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :math_rank, :integer
  end
end
