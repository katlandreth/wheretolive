<%= @class_name %>
<%= @plural_name %>
<%= @plural_name.singularize %>

# desc 'scrape cost of living data from Numbeo.com'
# task cost_of_living_rank: :environment do
#   driver = ::Selenium::WebDriver.for :firefox
#
#   puts "loading https://www.numbeo.com/cost-of-living/rankings_by_country.jsp..."
#   driver.get "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp"
#
#   puts "finding rows..."
#   rows = driver.find_elements(:css, "#t2 tbody tr")
#
#   puts "finding cells..."
#   rows.each do |row|
#     puts "scraping data..."
#     name = row.find_element(:css, "td:nth-of-type(2)").text
#     rank = row.find_element(:css, "td:nth-of-type(3)").text
#
#     if country = Country.find_by(name: name)
#       if record = country.ranks.find_by(name: "cost_of_living_rank")
#         puts "updating rank for existing country..."
#         record.update(name: "cost_of_living_rank", score: rank, order: "asc")
#       else
#         puts "createing rank for existing country..."
#         country.ranks.create(name: "cost_of_living_rank", score: rank, order: "asc")
#       end
#     else
#       puts "creating new country and rank..."
#       country = Country.create(name: name).ranks.create( name: "cost_of_living_rank", score: rank, order: "asc")
#     end
#   end
#
#   puts "all done!"
#   driver.quit
# end
