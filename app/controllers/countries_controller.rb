class CountriesController < ApplicationController

  before_action :lookup_country, only: [:show, :update, :edit, :destroy]
  before_action :categories, only: [:index, :default_results, :overall_rank]

  def index
    @countries = Country.all
    @current_results = default_results.reject{|v| v[:value] == 0 }.sort_by {|v|  v[:value]}
    @rank_json_data = Array.new.push( @countries.each { |c| c.as_json(only: [:name, :code]) } )
  end

  def show
    render :layout => 'show'
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

  def overall_rank
    @current_category = "overall_rank"
    @data = FilterAndSort.new(weight_params: weight_params, match_hash: deal_breaker_params).weighted_scores
    @countries = Country.all
    @current_results = @data.reject{ |d| d[:value] == 0 }.sort_by { |v|  v[:value] }
    @rank_json_data = Array.new.push( @countries.each { |c| c.as_json(only: [:name, :code]) } )
    respond_to_js
  end


  def category_filter
    @categories = category_params.select{|k, v| v == "1"}.keys
    session[:categories] = @categories
    respond_to_js
  end


  private

  def country_params
    params.require(:country).permit(:name, :population, :cost_of_living_score, :life_satisfaction_score, :education_score, :freedom_of_press_score)
  end

  def category_params
    params.require(:category_filter).permit(CATEGORIES)
  end

  def weight_params
    rank_params[:weights]
  end

  def deal_breaker_params
    categories = @categories
    deal_breakers = {}
    @categories.each{ |cat| deal_breakers[cat] = rank_params[cat]["min"], rank_params[cat]["max"] }
    deal_breakers
  end

  def rank_params
    deal_breaker_range_params = @categories.map{ |cat| "#{cat.to_sym} => ['min', 'max']" }.join(",")
    weight_value_params = @categories.map{ |cat| cat + "_value" }
    params.require(:overall_rank).permit(
      weights:["education_score_value", "life_satisfaction_score_value", "freedom_of_press_score_value", "cost_of_living_score_value", "population", "population_density"],
      education_score:['min', 'max'],
      life_satisfaction_score:['min', 'max'],
      freedom_of_press_score:['min', 'max'],
      cost_of_living_score:['min', 'max'],
      population:['min', 'max'],
      population_density:['min', 'max']
    )
  end

  def current_results
    params[:current_results].reject{|v| v[:value] == 0 }.sort_by {|v|  v[:value]}
  end

  def lookup_country
    @country = Country.find(params[:id])
  end

  def default_results
    @current_category = "overall_rank"
    @data = FilterAndSort.new().weighted_scores
  end

  def respond_to_js
    respond_to do |format|
      format.html
      format.js
    end
  end

  def categories
    @categories = session[:categories] || default_categories
  end

  def selected_categories
    category_params
  end

  def default_categories
    %w[education_score life_satisfaction_score freedom_of_press_score cost_of_living_score]
  end
end
