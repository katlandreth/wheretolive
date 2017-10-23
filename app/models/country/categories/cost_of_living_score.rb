class Categories::CostOfLivingScore

  def self.slider_min
    Country.pluck(:cost_of_living_score).reject{|s| s == nil}.min
  end

  def self.slider_max
    Country.pluck(:cost_of_living_score).reject{|s| s == nil}.max
  end

  def self.slider_initial_values
    [ slider_min, slider_max ]
  end

  def self.slider_input_id
    "cost_of_living_score_range_input"
  end

  def self.slider_div_id
    "cost_of_living_score_range_div"
  end

  def self.category_name
    "Cost of Living Score"
  end

end
