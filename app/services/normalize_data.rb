class NormalizeData

  def initialize(table)
    @table = table.titleize.constantize
  end

  def normalized_category_ranks(table, initial_order, min = 1, max = 100)

    scores = raw_scores(table)
    current_min = initial_order == "asc" ? min_value(table) : max_value(table)
    current_max = initial_order == "asc" ? max_value(table) : min_value(table)

    current_range = current_max - current_min
    target_range = (max - min).to_f

    scores.map! { |name, n| [name, ( min + (n - current_min) * (target_range / current_range) ).round(2)]}
    scores.to_h
  end

  def raw_scores(table)
    table.constantize.pluck(:country_name, :score).reject{ |r| r[1] == 0  }.reject{ |r| junk_data.include?(r[0]) }
  end

  def max_value(table)
    table.constantize.pluck(:score).reject{ |r| r == 0 }.max
  end

  def min_value(table)
    table.constantize.pluck(:score).reject{ |r| r == 0 }.min
  end

  def junk_data
    ["Selected countries and jurisdictions", "International Average (OECD)"]
  end

  def self.attribute_name_from_raw_table(table)
    table.underscore.gsub("raw_", "").to_sym
  end

  def self.attribute_name_from_country_data_table(table)
    if table == "CountryCode"
      table.underscore.to_sym
    else
      table.gsub("Country", "").underscore.to_sym
    end
  end
  
end
