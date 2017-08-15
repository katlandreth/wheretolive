class ChangeCountryScoresToFloat < ActiveRecord::Migration
  def up
   change_column :countries, :reading_score, :float
   change_column :countries, :science_score, :float
   change_column :countries, :math_score, :float
   change_column :countries, :life_satisfaction_score, :float
   change_column :countries, :freedom_of_press_score, :float
   change_column :countries, :cost_of_living_score, :float
 end

 def down
   change_column :countries, :reading_score, :string
   change_column :countries, :science_score, :string
   change_column :countries, :math_score, :string
   change_column :countries, :life_satisfaction_score, :string
   change_column :countries, :freedom_of_press_score, :string
   change_column :countries, :cost_of_living_score, :string
 end
end
