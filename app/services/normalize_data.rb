class NormalizeData

  def initialize(table)
    @table = table.titleize.constantize
  end

  def normalize_category_ranks(attr, min = 1, max = 100)
    ranks = ranks_for_attr(attr)
    initial_order = order_for_attr(attr)
    current_min = initial_order == "asc" ? min_value(attr) : max_value(attr)
    current_max = initial_order == "asc" ? max_value(attr) : min_value(attr)
    ranks.map! { |id, n| [id, ( min + (n - current_min) * (max - min) / (current_max - current_min) ).round]}
    ranks.to_h
  end

  def ranks_for_attr(attr)
    Rank.where(name: attr).pluck(:country_id, :score).reject{ |r| r[1] == nil }
  end

  def order_for_attr(attr)
    Rank.where(name: attr).first.order
  end

  def max_value(attr)
    Rank.where(name: attr).pluck(:score).reject{ |r| r == nil }.max
  end

  def min_value(attr)
    Rank.where(name: attr).pluck(:score).reject{ |r| r == nil }.min
  end

  def non_data_columns
    ["id", "latitude", "name", "created_at", "updated_at", "longitude", "code"]
  end
end
