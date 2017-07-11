class CountriesController < ApplicationController

  before_action :lookup_country, only: [:show, :update, :edit, :destroy]

  def index
    @countries = Country.all.includes(:ranks)
    @rank_json_data = Array.new.push(
      @countries.each do |c|
        c.as_json(only: [:name, :code])
      end
    )
    # attrs = ["cost_of_living_rank", "life_satisfaction_rank", "freedom_of_press_rank", "reading_rank", "math_rank", "science_rank"]
    # attrs.each do |attr|
    #   instance_variable_set("@normalized_#{attr}_column", NormalizeData.new("country").normalize_category_ranks(attr, 1, 100))
    # end
  end

  def show
  end

  def new
    @country = Country.new
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      redirect_to countries_path
    end
  end

  def edit
  end

  def update
    if @country.update(country_params)
      redirect_to countries_path
    end
  end

  def destroy
    @country.destroy
    redirect_to countries_path
  end

  def world_map
  end

  private

  def country_params
    params.require(:country).permit(:name, :population, :cost_of_living_rank, :life_satisfaction_rank, :longitude, :latitude, :math_rank, :science_rank, :reading_rank)
  end

  def lookup_country
    @country = Country.find(params[:id])
  end
end
