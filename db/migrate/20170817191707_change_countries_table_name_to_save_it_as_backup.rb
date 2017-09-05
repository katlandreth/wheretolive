class ChangeCountriesTableNameToSaveItAsBackup < ActiveRecord::Migration

  def self.up
    rename_table :countries, :countries_backup
  end

  def self.down
    rename_table :countries_backup, :countries
  end

end
