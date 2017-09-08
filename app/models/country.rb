class Country < ActiveRecord::Base
  validates :name, presence: true

  def self.non_data_columns
    ["id", "created_at", "updated_at", "name", "country_code"]
  end

  def range(attribute)
    first, last, twentyfifth, fiftieth, seventyfifth = percentiles(attribute)
      case self.send(attribute)
      when nil
        range = "no data"
      when first...twentyfifth
        range = "low"
      when twentyfifth...fiftieth
        range = "medium"
      when fiftieth...seventyfifth
        range = "high"
      when seventyfifth..last
        range = "very high"
      end
      range
  end

  def percentiles(attribute)
    values_sorted = Country.pluck("#{attribute.to_sym}").reject{ |v| v == nil }.sort
    percentiles = [values_sorted.first, values_sorted.last]
    [0.25, 0.50, 0.75].each do |percentile|
      k = (percentile*(values_sorted.length-1)+1).floor - 1
      f = (percentile*(values_sorted.length-1)+1).modulo(1)
      percentiles.push( values_sorted[k] + (f * (values_sorted[k+1] - values_sorted[k])) )
    end
    percentiles
  end

end
