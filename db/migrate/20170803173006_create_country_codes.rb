class CreateCountryCodes < ActiveRecord::Migration
  def change
    create_table :country_codes do |t|
      t.string :country_name
      t.string :code

      t.timestamps null: false
    end
  end
end
