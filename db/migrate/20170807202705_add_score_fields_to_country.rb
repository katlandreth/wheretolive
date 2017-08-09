class AddScoreFieldsToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :reading_score, :string
    add_column :countries, :science_score, :string
    add_column :countries, :math_score, :string
    add_column :countries, :life_satisfaction_score, :string
    add_column :countries, :freedom_of_press_score, :string
    add_column :countries, :cost_of_living_score, :string
  end
end
