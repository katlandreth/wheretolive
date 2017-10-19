class AddEducationScoreToCountry < ActiveRecord::Migration
  def change
    add_column :countries, :education_score, :float
  end
end
