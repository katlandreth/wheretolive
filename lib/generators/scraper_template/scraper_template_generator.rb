class ScraperTemplateGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  class_option :file_name, type: :string
  class_option :description, type: :string, default: '"no description"'
  class_option :url, type: :string, default: 'no_url'


  def new()
    @file_name = options['file_name']
    @description = options['description']
    @url = options['url']

    rakefile "#{@file_name}.rake" do
      %Q{
        desc '#{@description}'
        task #{@file_name}: :environment do
          driver = ::Selenium::WebDriver.for :firefox

          puts "#{@url}..."
          driver.get "#{@url}"

          wait = Selenium::WebDriver::Wait.new(:timeout => 20)
          wait.until {driver.find_element(:css, "XXXX").text}

          puts "finding rows..."
          rows = driver.find_elements(:css, "XXXX")

          puts "finding cells..."
          rows.each do |row|
            puts "scraping data..."
            name = row.find_element(:css, "XXXX").text
            score = row.find_element(:css, "XXXX").text

            if country = #{@file_name.camelize.constantize}.find_by(name: name)
              puts "updating rank for existing country..."
              country.update(country_name: name, score: score, order: "XXXX")
            else
              puts "creating new country and score..."
              country = #{@file_name.camelize.constantize}.create(country_name: name, score: score)
            end
          end

          puts "all done!"
          driver.quit
        end
      }
    end
  end

end
