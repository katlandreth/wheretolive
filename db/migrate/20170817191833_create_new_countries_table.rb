class CreateNewCountriesTable < ActiveRecord::Migration
  def change
    create_table :countries do |t|

      t.integer  :population
      t.string   :name
      t.string   :code
      t.float    :reading_score
      t.float    :science_score
      t.float    :math_score
      t.float    :life_satisfaction_score
      t.float    :freedom_of_press_score
      t.float    :cost_of_living_score

    end
  end
end
