class ChangeCountryScoresToFloat < ActiveRecord::Migration
  def up
   change_column :countries, :reading_score, 'double precision USING CAST(reading_score AS double precision)'
   change_column :countries, :science_score, 'double precision USING CAST(science_score AS double precision)'
   change_column :countries, :math_score, 'double precision USING CAST(math_score AS double precision)'
   change_column :countries, :life_satisfaction_score, 'double precision USING CAST(life_satisfaction_score AS double precision)'
   change_column :countries, :freedom_of_press_score, 'double precision USING CAST(freedom_of_press_score AS double precision)'
   change_column :countries, :cost_of_living_score, 'double precision USING CAST(cost_of_living_score AS double precision)'
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
