class Country < ActiveRecord::Base

  has_many :ranks, dependent: :destroy
  has_many :normal_cost_of_living_ranks,    -> { where(name: "cost_of_living_rank") }, class_name: "Rank"
  has_many :normal_life_satisfaction_ranks, -> { where(name: "life_satisfaction_rank") }, class_name: "Rank"
  has_many :normal_freedom_of_press_ranks,  -> { where(name: "freedom_of_press_rank") }, class_name: "Rank"
  has_many :normal_reading_ranks,           -> { where(name: "reading_rank") }, class_name: "Rank"
  has_many :normal_math_ranks,              -> { where(name: "math_rank") }, class_name: "Rank"
  has_many :normal_science_ranks,           -> { where(name: "science_rank") }, class_name: "Rank"

  delegate :cost_of_living_rank, :life_satisfaction_rank, :freedom_of_press_rank,
   :reading_rank, :math_rank, :science_rank, :normal_cost_of_living_rank,
   :normal_life_satisfaction_rank, :normal_freedom_of_press_rank, :normal_reading_rank,
   :normal_math_rank, :normal_science_rank, to: :ranks

  # def self.normalize_category_ranks(attr, initial_order, min = 1, max = 100)
  #   ranks = ranks_for_attr(attr)
  #   current_min = initial_order == "asc" ? Country.min_value(attr) : Country.max_value(attr)
  #   current_max = initial_order == "asc" ? Country.max_value(attr) : Country.min_value(attr)
  #
  #   ranks.map { |id, n| [id, ( min + (n - current_min) * (max - min) / (current_max - current_min) ).round] }
  # end

  def normalized_rank(attr)

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
