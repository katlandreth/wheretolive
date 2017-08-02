desc '"no description"'
task raw_life_satisfaction_score: :environment do
  driver = ::Selenium::WebDriver.for :firefox

  puts "http://www.oecdbetterlifeindex.org/topics/life-satisfaction/..."
  driver.get "http://www.oecdbetterlifeindex.org/topics/life-satisfaction/"

  wait = Selenium::WebDriver::Wait.new(:timeout => 40)
  wait.until { driver.find_element(:class => "rankIndex") }

  puts "finding rows..."
  entries = driver.find_elements(:class, "expandable")

  puts "finding cells..."
  entries.each do |entry|
    puts "scraping data..."
    driver.execute_script('jQuery(".expandable .row").show()')
    name = entry.find_element(:css, 'h2').text.remove(entry.find_element(:css, 'h2 span').text).remove(entry.find_element(:css, 'h2 a span').text).remove("\n")
    score = entry.find_element(:css, '.span3 .minichart .countryRank .rankIndex').text

    if country = RawLifeSatisfactionScore.find_by(country_name: name)
      puts "updating rank for existing country..."
      country.update(country_name: "raw_life_satisfaction_score", score: score, order: "asc")
    else
      puts "creating new country and score..."
      country = RawLifeSatisfactionScore.create(country_name: name, score: score)
    end
  end

  puts "all done!"
  driver.quit
end
