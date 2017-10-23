class Country::Category::Population < ActiveRecord::Base

  def self.unit
    "people"
  end
end
