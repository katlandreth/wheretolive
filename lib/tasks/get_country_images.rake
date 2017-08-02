desc 'get google image'
task get_country_images: :environment do
  driver = ::Selenium::WebDriver.for :chrome
  puts "Time to make the doughnuts..."

  Country.all[199..-1].each do | country |
    IO.popen('pbcopy', 'w') { |f| f << country.name.delete(' ') }

    driver.get("https://www.google.com/imghp?hl=en&tab=wi")

    inputElement = driver.find_element(:name, "q")
    inputElement.send_keys(country.name)
    inputElement.submit

    tools_button = driver.find_element(:id, "hdtb-tls")
    tools_button.click

    wait = Selenium::WebDriver::Wait.new(:timeout => 40)
    wait.until { driver.find_element(:xpath, "//*[contains(text(), 'Usage rights')]") }

    usage_rights = driver.find_element(:xpath, "//*[contains(text(), 'Usage rights')]")
    sleep 1
    usage_rights.click

    wait = Selenium::WebDriver::Wait.new(:timeout => 40)
    wait.until { driver.find_element(:css, "#sur_fc a") }
    sleep 1
    labeled_for_reuse = driver.find_element(:css, "#sur_fc a")

    labeled_for_reuse.click

    print "Find a good image"
    STDIN.gets
  end

  puts "Done making doughnuts."
end
