class CountriesController < ApplicationController

  before_action :lookup_country, only: [:show, :update, :edit, :destroy]
  before_action :categories, only: [:index, :default_results, :overall_rank]

  def index
    @countries = Country.all
    @current_results = default_results.reject{|v| v[:value] == 0 }.sort_by {|v|  v[:value]}
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

  def overall_rank
    puts "getting the overall rank"
    @current_category = "overall_rank"
    @data = FilterAndSort.new(weight_params, match_hash).weighted_scores
    @countries = Country.all
    @current_results = @data.reject{ |d| d[:value] == 0 }.sort_by { |v|  v[:value] }
    @rank_json_data = Array.new.push( @countries.each { |c| c.as_json(only: [:name, :code]) } )
    respond_to_js
  end


  private

  def current_results
    params[:current_results].reject{|v| v[:value] == 0 }.sort_by {|v|  v[:value]}
  end

  def country_params
    params.require(:country).permit(:name, :population, :cost_of_living_score, :life_satisfaction_score, :education_score, :freedom_of_press_score)
  end

  def lookup_country
    @country = Country.find(params[:id])
  end

  def default_results
    @current_category = "overall_rank"
    @data = FilterAndSort.new().weighted_scores
  end

  def weight_params
    permitted = @categories.map { |category| category + "_value" }
    params.require(:category_weights).permit(permitted)
  end

  def respond_to_js
    respond_to do |format|
      format.html
      format.js
    end
  end

  def categories
    @categories = CATEGORIES
  end
end
