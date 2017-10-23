class Categories::LifeSatisfactionScore

  def self.slider_min
    Country.pluck(:life_satisfaction_score).reject{|s| s == nil }.min
  end

  def self.slider_max
    Country.pluck(:life_satisfaction_score).reject{|s| s == nil }.max
  end

  def self.slider_initial_values
    [slider_min, slider_max]
  end

  def self.slider_input_id
    "life_satisfaction_score_range_input"
  end

  def self.slider_div_id
    "life_satisfaction_score_range_div"
  end

  def self.category_name
    "Life Satisfaction Score"
  end

end
