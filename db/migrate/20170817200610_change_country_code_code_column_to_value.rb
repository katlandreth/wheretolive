class ChangeCountryCodeCodeColumnToValue < ActiveRecord::Migration
  def up
    rename_column :country_codes, :code, :value
  end

  def down
    rename_column :country_codes, :value, :code
  end
end
