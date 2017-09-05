class ScrapeScores

  def initialize(category_class, driver)
    @category_class = category_class.constantize
    @driver = driver
  end

  def visit(url)
    puts "visiting #{url}..."
    @driver.get(url)
  end

  def wait_to_find(element)
    wait = Selenium::WebDriver::Wait.new(:timeout => 20)
    wait.until {@driver.find_element(:css, element).text}
  end

  def find_rows_by(css_selector)
    puts "finding rows..."
    @rows = @driver.find_elements(:css, css_selector)
  end

  def find_cells_by(name_selector, score_selector)
    puts "finding cells..."
    @rows.each do |row|
      puts "scraping data..."
      name = row.find_element(:css, name_selector).text
      score = row.find_element(:css, score_selector).text.gsub(/[^\d^\.]/, '').to_f
      record_data_for_country(name, score)

    end
  end

  def record_data_for_country(name, score)

    if country = @category_class.find_by(country_name: name)
      puts "updating rank for #{name}..."
      country.update(country_name: name, score_or_value => score)
    else
      puts "creating new country and score for #{name}..."
      country = @category_class.create(country_name: name, score_or_value => score)
    end
  end

  def quit
    puts "all done!"
    @driver.quit
  end

  def score_or_value
    return "score" if @category_class.column_names.include? "score"
    return "value" if @category_class.column_names.include? "value"
  end
end
