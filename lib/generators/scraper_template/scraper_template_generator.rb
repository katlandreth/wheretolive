class ScraperTemplateGenerator < Rails::Generators::Base
  # source_root File.expand_path('../templates', __FILE__)
  class_option :file_name, type: :string
  class_option :description, type: :string, default: '"no description"'
  class_option :url, type: :string, default: 'no url'


  def new()
    @file_name = options['file_name']
    @url = options['url']

    rakefile "scrapers/#{@file_name}.rake" do
%Q{
  namespace :scrape do
    desc 'get #{@file_name.humanize(capitalize: false)} data from #{@url}'
    task #{@file_name}: :environment do
      driver = ::Selenium::WebDriver.for :firefox

      scraper = ScrapeScores.new('#{@file_name.camelize.titleize}', driver)

      scraper.visit("#{@url}")
      scraper.wait_to_find("XXXX")
      scraper.find_rows_by("XXXX")
      scraper.find_cells_by("COUNTRY_NAME_CELL", "COUNTRY_DATA_CELL")
      scraper.quit
    end
  end
}
    end
  end

end
