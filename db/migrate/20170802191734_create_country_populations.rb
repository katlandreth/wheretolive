class CreateCountryPopulations < ActiveRecord::Migration
  def change
    create_table :country_populations do |t|
      t.string :country_name
      t.float :data

      t.timestamps null: false
    end
  end
end
