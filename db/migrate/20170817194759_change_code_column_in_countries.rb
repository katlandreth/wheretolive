class ChangeCodeColumnInCountries < ActiveRecord::Migration
  def up
    rename_column :countries, :code, :country_code
  end

  def down
    rename_column :countries, :country_code, :code
  end
end
