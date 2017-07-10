namespace :scrape_ranks do

  desc 'scrape cost of living data from Numbeo.com'
  task cost_of_living_rank: :environment do
    driver = ::Selenium::WebDriver.for :firefox

    puts "loading https://www.numbeo.com/cost-of-living/rankings_by_country.jsp..."
    driver.get "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp"

    puts "finding rows..."
    rows = driver.find_elements(:css, "#t2 tbody tr")

    puts "finding cells..."
    rows.each do |row|
      puts "scraping data..."
      name = row.find_element(:css, "td:nth-of-type(2)").text
      rank = row.find_element(:css, "td:nth-of-type(3)").text

      if country = Country.find_by(name: name)
        if record = country.ranks.find_by(name: "cost_of_living_rank")
          puts "updating rank for existing country..."
          record.update(name: "cost_of_living_rank", score: rank, order: "asc")
        else
          puts "createing rank for existing country..."
          country.ranks.create(name: "cost_of_living_rank", score: rank, order: "asc")
        end
      else
        puts "creating new country and rank..."
        country = Country.create(name: name).ranks.create( name: "cost_of_living_rank", score: rank, order: "asc")
      end
    end

    puts "all done!"
    driver.quit
  end

  desc 'scrape life satisfaction data from OCED.com'
  task life_satisfaction_rank: :environment do

    driver = ::Selenium::WebDriver.for :firefox
    driver.get "http://www.oecdbetterlifeindex.org/topics/life-satisfaction/"

    wait = Selenium::WebDriver::Wait.new(:timeout => 40)
    wait.until { driver.find_element(:class => "rankIndex") }

    entries = driver.find_elements(:class, "expandable")
    entries.each do |entry|
      driver.execute_script('jQuery(".expandable .row").show()')
      name = entry.find_element(:css, 'h2').text.remove(entry.find_element(:css, 'h2 span').text).remove(entry.find_element(:css, 'h2 a span').text).remove("\n")
      rank = entry.find_element(:css, '.span3 .minichart .countryRank .rankIndex').text

      if country = Country.find_by(name: name)
        if record = country.ranks.find_by(name: "life_satisfaction_rank")
          record.update(name: "life_satisfaction_rank", score: rank, order: "asc")
        else
          country.ranks.create(name: "life_satisfaction_rank", score: rank, order: "asc")
        end
      else
        country = Country.create(name: name).ranks.create(name: "life_satisfaction_rank", score: rank, order: "asc")
      end

    end
    driver.quit
  end

  desc 'scrape education data from oecd.com - you mus pass an argument, either: "math_rank", "reading_rank", or "science_rank".'
  task :education_rank, [:subject] => [:environment] do |t, args|
    subject = args[:subject]
    driver = ::Selenium::WebDriver.for :firefox

    case subject
    when "math_rank"
      driver.get "http://pisadataexplorer.oecd.org/ide/idepisa/report.aspx?p=1-RMS-1-20153-PVMATH-TOTAL-IN2,IN3,AUS,AUT,BEL,CAN,CHL,CZE,DNK,EST,FIN,FRA,DEU,GRC,HUN,ISL,IRL,ISR,ITA,JPN,KOR,LVA,LUX,MEX,NLD,NZL,NOR,POL,PRT,SVK,SVN,ESP,SWE,CHE,TUR,GBR,USA,ALB,QLB,DZA,QRG,BRA,QCH,BGR,ARG01,COL,CRI,HRV,QCY,DOM,MKD,GEO,HKG,IDN,JOR,KAZ,QAZ,KSV,LBN,LTU,MAC,MYS,QYS,MLT,MDA,MNE,PER,QAT,ROU,RUS,SGP,TAP,THA,TTO,TUN,ARE,URY,VNM-MN_MN-Y_J-0-0-37&Lang=1033"
    when "reading_rank"
      driver.get "http://pisadataexplorer.oecd.org/ide/idepisa/report.aspx?p=1-RMS-1-20153-PVREAD-TOTAL-IN2,IN3,AUS,AUT,BEL,CAN,CHL,CZE,DNK,EST,FIN,FRA,DEU,GRC,HUN,ISL,IRL,ISR,ITA,JPN,KOR,LVA,LUX,MEX,NLD,NZL,NOR,POL,PRT,SVK,SVN,ESP,SWE,CHE,TUR,GBR,USA,ALB,QLB,DZA,QRG,BRA,QCH,BGR,ARG01,COL,CRI,HRV,QCY,DOM,MKD,GEO,HKG,IDN,JOR,KAZ,QAZ,KSV,LBN,LTU,MAC,MYS,QYS,MLT,MDA,MNE,PER,QAT,ROU,RUS,SGP,TAP,THA,TTO,TUN,ARE,URY,VNM-MN_MN-Y_J-0-0-37&Lang=1033"
    when "science_rank"
      driver.get "http://pisadataexplorer.oecd.org/ide/idepisa/report.aspx?p=1-RMS-1-20153-PVSCIE-TOTAL-IN2,IN3,AUS,AUT,BEL,CAN,CHL,CZE,DNK,EST,FIN,FRA,DEU,GRC,HUN,ISL,IRL,ISR,ITA,JPN,KOR,LVA,LUX,MEX,NLD,NZL,NOR,POL,PRT,SVK,SVN,ESP,SWE,CHE,TUR,GBR,USA,ALB,QLB,DZA,QRG,BRA,QCH,BGR,ARG01,COL,CRI,HRV,QCY,DOM,MKD,GEO,HKG,IDN,JOR,KAZ,QAZ,KSV,LBN,LTU,MAC,MYS,QYS,MLT,MDA,MNE,PER,QAT,ROU,RUS,SGP,TAP,THA,TTO,TUN,ARE,URY,VNM-MN_MN-Y_J-0-0-37&Lang=1033"
    end

    wait = Selenium::WebDriver::Wait.new(:timeout => 20)
    wait.until {driver.find_element(:css, "#rgReport_ctl00 tbody tr td").text}
    rows = driver.find_elements(:css, "#rgReport_ctl00 tbody tr")
    rows.each do |row|
      name = row.find_element(:css, "th:nth-of-type(2)").text
      rank = row.find_element(:css, "td:nth-of-type(1)").text

      if country = Country.find_by(name: name)
        if record = country.ranks.find_by(name: "#{subject.to_sym}")
          record.update(name: "#{subject.to_sym}", score: rank, order: "desc")
        else
          country.ranks.create(name: "#{subject.to_sym}", score: rank, order: "desc")
        end
      else
        country = Country.create(name: name).ranks.create(name: "#{subject.to_sym}", score: rank, order: "desc")
      end
    end

    driver.quit
  end

  desc 'scrape freedom of press data from rsf.org'
  task freedom_of_press_rank: :environment do

    driver = ::Selenium::WebDriver.for :firefox
    driver.get "https://rsf.org/en/ranking"

    wait = Selenium::WebDriver::Wait.new(:timeout => 20)
    wait.until {driver.find_element(:css, "li.country_name_item span.ranking-map__panel-name").text}

    rows = driver.find_elements(:css, "li.country_name_item")

    rows.each do |row|
      name = row.find_element(:css, "span.ranking-map__panel-name").text
      rank = row.find_element(:css, "span.ranking-map__panel-rank").text

      if country = Country.find_by(name: name)
        if record = country.ranks.find_by(name: "freedom_of_press_rank")
          record.update(name: "freedom_of_press_rank", score: rank, order: "asc")
        else
          country.ranks.create(name: "freedom_of_press_rank", score: rank, order: "asc")
        end
      else
        country = Country.create(name: name, freedom_of_press_rank: rank)
      end
    end

    driver.quit
  end

end

namespace :scrape_country_details do

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

      if country = Country.find_by(name: name )
        puts "updating country detail..."
        country.update(code: code)
      else
        puts "creating new country..."
        country = Country.create(name: name, code: code)
      end
    end

    puts "all done!!"
    driver.quit
  end

  desc 'scrape gps data from techslides.com'
  task gps_data: :environment do

    driver = ::Selenium::WebDriver.for :firefox

    puts "loading http://techslides.com/list-of-countries-and-capitals..."
    driver.get "http://techslides.com/list-of-countries-and-capitals"

    puts "loading rows..."
    rows = driver.find_elements(:tag_name, "tr")

    puts "loading cells..."
    rows.each do |row|
      name      = row.find_element(:css, "td:nth-of-type(1)").text
      latitude  = row.find_element(:css, "td:nth-of-type(3)").text
      longitude = row.find_element(:css, "td:nth-of-type(4)").text

      if country = Country.find_by(name: name )
        puts "updating country details..."
        country.update(latitude: latitude, longitude: longitude)
      else
        puts "creating new country..."
        country = Country.create(name: name, latitude: latitude, longitude: longitude)
      end
    end

    puts "all done!"
    driver.quit
  end

end
