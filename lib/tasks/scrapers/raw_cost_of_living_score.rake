namespace :scrape do
  desc "scrape the raw cost of living score from Numbeo"
  task raw_cost_of_living_score: :environment do
    driver = ::Selenium::WebDriver.for :firefox

    scraper = ScrapeScores.new("RawCostOfLivingScore", driver)

    scraper.visit("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp")
    scraper.wait_to_find("#t2 tbody tr td")
    scraper.find_rows_by("#t2 tbody tr")
    scraper.find_cells_by("td:nth-of-type(2)", "td:nth-of-type(3)")
    scraper.quit

  end
end
