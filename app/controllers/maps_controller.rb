class MapsController < ApplicationController

  before_action :get_categories, only: [:show, :overall_rank]
  before_action :current_category, only: [:show]

  def show
    category_name = current_category
    @countries = Country.all

    @data = []
    @countries.each do |c|
      normal_rank = eval("c.#{category_name}") || 0
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

    countries = Country.all

    @data = []
    countries.each do |country|

      categories_with_values = Hash[categories.collect { |category| [category, eval("country.#{category}")] } ]
      if categories_with_values.values.include?(nil)
        tooltip = categories_with_values.map{ |category, value| value == nil ? category.titleize : nil }.compact.to_sentence(words_connector: ',<br>', last_word_connector: ',<br> and ')
        score = 0
      else
        weighted_categories = categories.map do |category|
          score = eval("country.#{category}").to_i
          score * weight_params["#{category}_value".to_sym].to_i
        end
        tooltip = ""
        score = weighted_categories.reduce(:+)/ weight_params.map{ |key, value| value.to_i }.reduce(:+)
      end
      json_data = {code: country.code, value: score, name: country.name, tooltip: tooltip}
      @data.push(json_data)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def get_categories
    @categories = %w[reading_score science_score math_score life_satisfaction_score freedom_of_press_score cost_of_living_score]
  end

  def current_category
    @current_category = params[:category] || "life_satisfaction_score"
  end

  def weight_params
    permitted = @categories.map { |category| category + "_value" }
    params.require(:category_weights).permit(permitted)
  end

end
