class Country::Category::Population < ActiveRecord::Base

  def self.unit
    "people"
  end

  def self.slider_min
    Country.pluck(:population).reject{|s| s == nil }.min
  end

  def self.slider_max
    Country.pluck(:population).reject{|s| s == nil }.max
  end

  def self.slider_initial_values
    [slider_min, slider_max]
  end

  def self.slider_input_id
    "population_range_input"
  end

  def self.slider_div_id
    "population_range_div"
  end

  def self.category_name
    "Population"
  end

end
