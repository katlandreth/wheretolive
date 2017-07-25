class Rank < ActiveRecord::Base
  belongs_to :country

  def self.cost_of_living_rank
    if category = find_by(name: "cost_of_living_rank")
      category
    else
      nil
    end
  end

  def self.life_satisfaction_rank
    if category = find_by(name: "life_satisfaction_rank")
      category
    else
      nil
    end
  end

  def self.freedom_of_press_rank
    if category = find_by(name: "freedom_of_press_rank")
      category
    else
      nil
    end
  end

  def self.reading_rank
    if category = find_by(name: "reading_rank")
      category
    else
      nil
    end
  end

  def self.math_rank
    if category = find_by(name: "math_rank")
      category
    else
      nil
    end
  end

  def self.science_rank
    if category = find_by(name: "science_rank")
      category
    else
      nil
    end
  end

  def self.normal_cost_of_living_rank
    if category = find_by(name: "cost_of_living_rank")
      category.normalized_score
    else
      nil
    end
  end

  def self.normal_life_satisfaction_rank
    if category = find_by(name: "life_satisfaction_rank")
      category.normalized_score
    else
      nil
    end
  end

  def self.normal_freedom_of_press_rank
    if category = find_by(name: "freedom_of_press_rank")
      category.normalized_score
    else
      nil
    end
  end

  def self.normal_reading_rank
    if category = find_by(name: "reading_rank")
      category.normalized_score
    else
      nil
    end
  end

  def self.normal_math_rank
    if category = find_by(name: "math_rank")
      category.normalized_score
    else
      nil
    end
  end

  def self.normal_science_rank
    if category = find_by(name: "science_rank")
      category.normalized_score
    else
      nil
    end
  end

  def self.weighted_average(country, weights)
    
    byebug

  end

end
