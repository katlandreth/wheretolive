class CreateCountryAliases < ActiveRecord::Migration
  def change
    create_table :country_aliases do |t|
      t.string :name
      t.references :country_display_name, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
