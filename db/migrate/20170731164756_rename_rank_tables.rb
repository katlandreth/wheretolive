class RenameRankTables < ActiveRecord::Migration
  def up
    rename_table :science_ranks,           :raw_science_scores
    rename_table :freedom_of_press_ranks,  :raw_freedom_of_press_scores
    rename_table :life_satisfaction_ranks, :raw_life_satisfaction_scores
    rename_table :cost_of_living_ranks,    :raw_cost_of_living_scores
    rename_table :math_ranks,              :raw_math_scores
    rename_table :reading_ranks,           :raw_reading_scores
  end

  def down
    rename_table :raw_science_scores,           :science_ranks
    rename_table :raw_freedom_of_press_scores,  :freedom_of_press_ranks
    rename_table :raw_life_satisfaction_scores, :life_satisfaction_ranks
    rename_table :raw_cost_of_living_scores,    :cost_of_living_ranks
    rename_table :raw_math_scores,              :math_ranks
    rename_table :raw_reading_scores,           :reading_ranks
  end
end
