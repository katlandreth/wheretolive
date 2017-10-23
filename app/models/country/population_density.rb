class Country::PopulationDensity < ActiveRecord::Base

  def self.unit
    "People/KM^2"
  end
end
