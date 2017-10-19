module CountriesHelper

  def country_image(country_name)
    "https://s3-us-west-2.amazonaws.com/nerdyliving-expatapp/country-images/#{country_name.delete(" ")}.jpg"
  end

  def cost_of_living_graph(country_name)
    if score = Country.find_by(name: country_name).cost_of_living_score
      percent = 100 - score
      "#{percent}%"
    else
      "100%"
    end
  end

  def life_satisfaction_graph(country_name)
    if score = Country.find_by(name: country_name).life_satisfaction_score
      percent = 100 - score
      "#{percent}%"
    else
      "100"
    end
  end

  def freedom_of_press_graph(country_name)
    if score = Country.find_by(name: country_name).freedom_of_press_score
      percent = 100 - score
      "#{percent}%"
    else
      "100"
    end
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
    category_class(category).category_name
  end

  def slider_div_id(category)
    category_class(category).slider_div_id
  end

  def slider_input_min_id(category)
    category_class(category).slider_input_id + "_min"
  end

  def slider_input_max_id(category)
    category_class(category).slider_input_id + "_max"
  end

  def category_class(category)
    "Categories::#{category.camelize}".constantize
  end

  def slider_min(category)
    category_class(category).slider_min
  end

  def slider_max(category)
    category_class(category).slider_max
  end

  def slider_catgory_data(category)
    @ruby_data = {
      slider_min: category_class(category).slider_min,
      slider_max: category_class(category).slider_max,
      slider_initial_values: category_class(category).slider_initial_values,
      slider_div_id: "#" + category_class(category).slider_div_id,
      slider_input_min_id: "#" + slider_input_min_id(category),
      slider_input_max_id: "#" + slider_input_max_id(category)
    }
  end


end
