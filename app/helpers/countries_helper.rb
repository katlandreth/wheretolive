module CountriesHelper

  def country_image(country_name)
    "country_images/#{country_name.delete(" ")}.jpg"
  end
end
