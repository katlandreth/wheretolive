class Country::Category::EducationScore

  def self.slider_min
    all_education_scores.min
  end

  def self.slider_max
    all_education_scores.max
  end

  def self.slider_initial_values
    [slider_min, slider_max]
  end

  def self.slider_input_id
    "education_score_range_input"
  end

  def self.slider_div_id
    "education_score_range_div"
  end

  def self.category_name
    "Education Score"
  end

  def self.all_education_scores
    scores = []
    Country.all.each{ |c| scores.push c.education_score }
    scores.reject{|s| s == nil}
  end

end
