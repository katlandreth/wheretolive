desc 'do a pixabay free image search for each country name, pauses for user to select and download image'
task get_missing_country_images: :environment do
  driver = ::Selenium::WebDriver.for :chrome
  puts "Time to make the doughnuts..."

  display_names =  Country::Alias.distinct.pluck(:display_name).each do |name|
    name.tr!(" ", "")
  end

  image_file_names = Dir.entries("./app/assets/images/country_images").reject!{|name| [".", "..", ".DS_Store"].include?(name)}.each{|name| name.gsub!(".jpg", "")}

  missing_countries = display_names - image_file_names

  missing_countries.each do | country |
    IO.popen('pbcopy', 'w') { |f| f << country }

    driver.get("https://pixabay.com")

    inputElement = driver.find_element(:id, "id_q")
    inputElement.send_keys(country)
    inputElement.submit

    print "Find a good image"
    STDIN.gets
  end
  driver.quit
  puts "Done making doughnuts."
end
