class DropUnusedTables < ActiveRecord::Migration
  def change

    remove_foreign_key "country_aliases", column: "country_id"
    remove_foreign_key "country_aliases", column: "country_display_name_id"

    drop_table :country_display_names
    drop_table :codes
    drop_table :ranks
    drop_table :countries_backup
    drop_table :populations

  end
end
