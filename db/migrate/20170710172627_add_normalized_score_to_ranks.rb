class AddNormalizedScoreToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :normalized_score, :integer
  end
end
