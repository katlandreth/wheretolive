class AddDisplayNameToCountryAlias < ActiveRecord::Migration
  def change
    add_column :country_aliases, :display_name, :string
  end
end
