class RawScores::RawCostOfLivingScore < ActiveRecord::Base

  def self.raw_score_order
    "asc"
  end
end
