class CreateCountryPopulationDensities < ActiveRecord::Migration
  def change
    create_table :country_population_densities do |t|
      t.string :country_name
      t.float :value
    end
  end
end
