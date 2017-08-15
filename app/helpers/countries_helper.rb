module CountriesHelper

  def country_image(country_name)
    "country_images/#{country_name.delete(" ")}.jpg"
  end

  def cost_of_living_graph(country_name)
    percent = 100 - Country.find_by(name: country_name).cost_of_living_score
    "#{percent}%"
  end

  def life_satisfaction_graph(country_name)
    percent = 100 - Country.find_by(name: country_name).life_satisfaction_score
    "#{percent}%"
  end

  def freedom_of_press_graph(country_name)
    percent = 100 - Country.find_by(name: country_name).freedom_of_press_score
    "#{percent}%"
  end
end
