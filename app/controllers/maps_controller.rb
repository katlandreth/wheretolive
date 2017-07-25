class MapsController < ApplicationController

  before_action :get_categories, only: [:show, :overall_rank]
  before_action :get_current_category, only: [:show]

  def show
    association_name = get_association_name(get_current_category)
    @countries = Country.includes(association_name)

    @data = []
    @countries.each do |c|
      normal_rank = eval("c.#{association_name}.try(:first).try(:normalized_score)") || 0
      json_data = {code: c.code, value: normal_rank, name: c.name}
      @data.push(json_data)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def overall_rank
    @current_category = "overall_rank"
    categories = weight_params.reject{|key, value| value == "0"}.keys.map{ |key| key.gsub("_value", "") }

    countries = Country.includes( :cost_of_living_ranks,
                                  :life_satisfaction_ranks,
                                  :freedom_of_press_ranks,
                                  :reading_ranks,
                                  :math_ranks,
                                  :science_ranks)

    @data = []
    countries.each do |country|

      categories_with_values = Hash[categories.collect { |category| [category, eval("country.#{category}s.try(:first).try(:normalized_score)")] } ]
      if categories_with_values.values.include?(nil)
        tooltip = categories_with_values.map{ |category, value| value == nil ? category.titleize : nil }.compact.to_sentence(words_connector: ',<br>', last_word_connector: ',<br> and ')
        rank = 0
      else
        weighted_categories = categories.map do |category|

          score = eval("country.#{category}s.try(:first).try(:normalized_score)")
          score * weight_params["#{category}_value".to_sym].to_i
        end
        tooltip = ""
        rank = weighted_categories.reduce(:+)/ weight_params.map{ |key, value| value.to_i }.reduce(:+)
      end
      json_data = {code: country.code, value: rank, name: country.name, tooltip: tooltip}
      @data.push(json_data)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_categories
    @categories = Rank.distinct.pluck(:name)
  end

  def weight_params
    permitted = @categories.map { |category| category + "_value" }
    params.require(:category_weights).permit(permitted)
  end

  def get_current_category
    @current_category = params[:category] || "life_satisfaction_rank"
  end

  def get_association_name(current_category)
    "#{current_category}s".to_sym
  end
end
