namespace :scrape do
  desc 'scrape country population data from worldmeters.info'
  task country_population: :environment do
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.timeout = 120 # seconds
    driver = ::Selenium::WebDriver.for :chrome, http_client: client

    scraper = ScrapeScores.new("CountryPopulation", driver)

    scraper.visit("http://www.worldometers.info/world-population/population-by-country/")
    scraper.wait_to_find("table#example2 tbody td.sorting_1")
    scraper.find_rows_by("table#example2 tbody tr")
    scraper.find_cells_by("td:nth-of-type(2)", "td:nth-of-type(3)")
    scraper.quit
  end
end
