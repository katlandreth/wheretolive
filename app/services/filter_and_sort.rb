class FilterAndSort

  def initialize(weight_params: default_weights, match_hash: nil)
    @weight_params = weight_params
    @categories = include_categories
    @countries = exclude_matching_places(match_hash)
  end

  def include_categories
    @weight_params.reject{|key, value| value == "0"}.keys.map{ |key| key.gsub("_value", "") }
  end

  def exclude_matching_places(match_hash)
    @countries = Country.all
      if match_hash != nil
        match_hash.each do |attribute, value_range|
          start, finish = attribute.camelize.constantize.send("#{value_range}")
          @countries = @countries.where.not("#{attribute} BETWEEN ? AND ?", start, finish)
        end
      end
    @countries
  end

  def weighted_scores
    @data = []
    @countries.each do |country|
      categories_with_values = Hash[@categories.collect { |category| [category, eval("country.#{category}")] } ]

      if categories_with_values.values.include?(nil)
        tooltip = categories_with_values.map{ |category, value| value == nil ? category.titleize : nil }.compact.to_sentence(words_connector: ',<br>', last_word_connector: ',<br> and ')
        score = 0
      else
        weighted_categories = @categories.map do |category|
          score = eval("country.#{category}").to_i
          score * @weight_params["#{category}_value".to_sym].to_i
        end
        tooltip = ""
        score = weighted_categories.reduce(:+)/ @weight_params.map{ |key, value| value.to_i }.reduce(:+)
      end

      json_data = {code: country.country_code, value: score, name: country.name, tooltip: tooltip}
      @data.push(json_data)
    end
    @data
  end

end

private

def default_weights
  {
    "education_score_value" => 5,
    "life_satisfaction_score_value" => 5,
    "freedom_of_press_score_value" => 5,
    "cost_of_living_score_value" => 5
  }.with_indifferent_access
end
