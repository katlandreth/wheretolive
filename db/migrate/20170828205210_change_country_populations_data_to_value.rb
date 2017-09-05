class ChangeCountryPopulationsDataToValue < ActiveRecord::Migration
  def up
    rename_column :country_populations, :data, :value
  end

  def down
    rename_column :country_populations, :value, :data
  end
end
