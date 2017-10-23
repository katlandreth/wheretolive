class Country::Category::FreedomOfPressScore

  def self.slider_min
    Country.pluck(:freedom_of_press_score).reject{|s| s == nil}.min
  end

  def self.slider_max
    Country.pluck(:freedom_of_press_score).reject{|s| s == nil}.max
  end

  def self.slider_initial_values
    [slider_min, slider_max]
  end

  def self.slider_input_id
    "freedom_of_press_score_range_input"
  end

  def self.slider_div_id
    "freedom_of_press_score_range_div"
  end

  def self.category_name
    "Freedom of Press Score"
  end

end
