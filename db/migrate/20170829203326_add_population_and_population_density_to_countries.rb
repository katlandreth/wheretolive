class AddPopulationAndPopulationDensityToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :population_density, :float
  end
end
