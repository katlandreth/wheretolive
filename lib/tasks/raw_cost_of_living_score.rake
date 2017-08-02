desc "no description"
task raw_cost_of_living_score: :environment do
  driver = ::Selenium::WebDriver.for :firefox

  puts "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp..."
  driver.get "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp"

  puts "finding rows..."
  rows = driver.find_elements(:css, "#t2 tbody tr")

  puts "finding cells..."
  rows.each do |row|
    puts "scraping data..."
    name = row.find_element(:css, "td:nth-of-type(2)").text
    score = row.find_element(:css, "td:nth-of-type(3)").text

    if country = RawCostOfLivingScore.find_by(country_name: name)
      puts "updating rank for existing country..."
      country.update(country_name: name, score: score, order: "asc")
    else
      puts "creating new country and score..."
      country = RawCostOfLivingScore.create(country_name: name, score: score)
    end
  end

  puts "all done!"
  driver.quit
end
