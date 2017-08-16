namespace :scrape do
  desc 'scrape the freedom of press score from rfs.org'
  task raw_freedom_of_press_score: :environment do
    driver = ::Selenium::WebDriver.for :firefox

    scraper = ScrapeScores.new("RawFreedomOfPressScore", driver)

    scraper.visit("https://rsf.org/en/ranking")
    scraper.wait_to_find("li.country_name_item span.ranking-map__panel-name")
    scraper.find_rows_by("li.country_name_item")
    scraper.find_cells_by("span.ranking-map__panel-name", "span.ranking-map__panel-score")
    scraper.quit
  end
end
