desc '"no description"'
task raw_freedom_of_press_score: :environment do
  driver = ::Selenium::WebDriver.for :firefox

  puts "https://rsf.org/en/ranking..."
  driver.get "https://rsf.org/en/ranking"

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)
  wait.until {driver.find_element(:css, "li.country_name_item span.ranking-map__panel-name").text}

  puts "finding rows..."
  rows = driver.find_elements(:css, "li.country_name_item")

  puts "finding cells..."
  rows.each do |row|
    puts "scraping data..."
    name = row.find_element(:css, "span.ranking-map__panel-name").text
    score = row.find_element(:css, "span.ranking-map__panel-rank").text

    if country = RawFreedomOfPressScore.find_by(country_name: name)
      puts "updating rank for existing country..."
      country.update(country_name: name, score: score, order: "asc")
    else
      puts "creating new country and score..."
      country = RawFreedomOfPressScore.create(country_name: name, score: score)
    end
  end

  puts "all done!"
  driver.quit
end
