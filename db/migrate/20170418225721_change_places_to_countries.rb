class ChangePlacesToCountries < ActiveRecord::Migration
  def up
    rename_table :places, :countries
  end

  def down
    rename_table :countries, :places
  end
end
