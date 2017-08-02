class CreatePopulation < ActiveRecord::Migration
  def change
    create_table :populations do |t|
      t.string :country_name
      t.float :value
    end
  end
end
