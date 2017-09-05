class CountriesController < ApplicationController

  before_action :lookup_country, only: [:show, :update, :edit, :destroy]
  before_action :categories, only: [:index, :default_results]

  def index
    @countries = Country.all
    @current_results = params[:current_results] || default_results.reject{|v| v[:value] == 0 }.sort_by {|v|  v[:value]}
    @rank_json_data = Array.new.push( @countries.each { |c| c.as_json(only: [:name, :code]) } )
  end

  def show
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)
    redirect_to countries_path if @country.save
  end

  def edit
  end

  def update
    redirect_to countries_path if @country.update(country_params)
  end

  def destroy
    @country.destroy
    redirect_to countries_path
  end


  private

  def current_results
    params[:current_results].reject{|v| v[:value] == 0 }.sort_by {|v|  v[:value]}
  end

  def country_params
    params.require(:country).permit(:name, :population, :cost_of_living_score, :life_satisfaction_score, :math_score, :science_score, :reading_score, :freedom_of_press_score)
  end

  def lookup_country
    @country = Country.find(params[:id])
  end

  def default_results

    @current_category = "overall_rank"
    @data = []
    countries = Country.all
    categories = @categories

    countries.each do |country|

      categories_with_values = Hash[categories.collect { |category| [category, eval("country.#{category}")] } ]
      if categories_with_values.values.include?(nil)
        tooltip = categories_with_values.map{ |category, value| value == nil ? category.titleize : nil }.compact.to_sentence(words_connector: ',<br>', last_word_connector: ',<br> and ')
        score = 0
      else
        weighted_categories = categories.map do |category|
          score = eval("country.#{category}").to_i
        end
        tooltip = ""
        score = weighted_categories.reduce(:+) / categories.count
      end
      json_data = {code: country.country_code, value: score, name: country.name, tooltip: tooltip}
      @data.push(json_data)
    end
    @data
  end


  def respond_to_js
    respond_to do |format|
      format.html
      format.js
    end
  end

  def categories
    @categories = %w[reading_score science_score math_score life_satisfaction_score freedom_of_press_score cost_of_living_score]
  end
end
