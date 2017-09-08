namespace :country_code do

  desc 'scrape country code data from nationsonline.org'
  task country_code: :environment do

    driver = ::Selenium::WebDriver.for :firefox

    puts "loading http://www.nationsonline.org/oneworld/country_code_list.htm..."
    driver.get "http://www.nationsonline.org/oneworld/country_code_list.htm"

    wait = Selenium::WebDriver::Wait.new(:timeout => 20)
    wait.until {driver.find_element(:css, "#codelist tbody tr td.abs").text}

    puts "loading rows..."
    rows = driver.find_elements(:css, "#codelist tbody tr")

    puts "loading cells..."
    rows.drop(2).each do |row|
      name      = row.find_element(:css, "td.abs").text
      code      = row.find_element(:css, "td:nth-of-type(3)").text

      if country = CountryCode.find_by(country_name: name )
        puts "updating country detail..."
        country.update(code: code)
      else
        puts "creating new country..."
        country = CountryCode.create(country_name: name, code: code)
      end
    end

    puts "all done!!"
    driver.quit
  end

end
