module CountriesHelper

  def country_image(country_name)
    "https://s3-us-west-2.amazonaws.com/nerdyliving-expatapp/country-images/#{country_name.delete(" ")}.jpg"
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

  def population_group(country)
    case country.popluation
      when small then puts "small"
      when medium then puts "medium"
      when large then puts "large"
    end
  end

  def population_density_group(country)
    case country.popluation_density
      when small then puts "small"
      when medium then puts "medium"
      when large then puts "large"
    end
  end

  def attribute_name(category)
    "Categories::#{category.camelize}".constantize.category_name
  end

  def slider_div_id(category)
    "Categories::#{category.camelize}".constantize.slider_div_id
  end

  def slider_input_id(category)
    "Categories::#{category.camelize}".constantize.slider_input_id
  end

  def slider_catgory_data(category)
    category_class = "Categories::#{category.camelize}".constantize
    @ruby_data = {
      slider_min: category_class.slider_min,
      slider_max: category_class.slider_max,
      slider_initial_values: category_class.slider_initial_values,
      slider_div_id: "#" + category_class.slider_div_id,
      slider_input_id: "#" + category_class.slider_input_id
    }
  end


end
