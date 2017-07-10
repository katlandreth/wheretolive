class Country < ActiveRecord::Base

  has_many :ranks, dependent: :destroy
  delegate :cost_of_living_rank, :life_satisfaction_rank, :freedom_of_press_rank,
   :reading_rank, :math_rank, :science_rank, to: :ranks
  def self.normalize_category_ranks(attr, initial_order, min = 1, max = 100)
    ranks = ranks_for_attr(attr)
    current_min = initial_order == "asc" ? Country.min_value(attr) : Country.max_value(attr)
    current_max = initial_order == "asc" ? Country.max_value(attr) : Country.min_value(attr)

    ranks.map { |id, n| [id, ( min + (n - current_min) * (max - min) / (current_max - current_min) ).round] }
  end

  def normalized_rank(attr)
    NormalizeData.new("country").normalize_category_ranks(attr, 1, 100)
  end

  def self.ranks_for_attr(attr)
    "SELECT id, #{attr} FROM countries WHERE #{attr} IS NOT NULL"
    # Country.pluck(:id, attr.to_sym).reject{ |r| r[1] == nil }
  end

  def self.max_value(attr)
    "SELECT MAX(#{attr}) FROM countries WHERE #{attr} IS NOT NULL"
    # Country.pluck(attr.to_sym).reject{ |r| r == nil }.max
  end

  def self.min_value(attr)
    "SELECT MIN(#{attr}) FROM countries WHERE #{attr} IS NOT NULL"
    # Country.pluck(attr.to_sym).reject{ |r| r == nil }.min
  end

end
