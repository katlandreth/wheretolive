class Country::Population < ActiveRecord::Base

  def self.unit
    "people"
  end
end
