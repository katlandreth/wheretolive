class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.integer :population
      t.integer :cost_of_living_rank
      t.integer :life_satisfaction_rank
      t.float :geolocation
      t.string :name

      t.timestamps null: false
    end
  end
end
