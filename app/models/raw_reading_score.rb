class RawReadingScore < ActiveRecord::Base

  def self.raw_score_order
    "desc"
  end
end
