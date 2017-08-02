desc '"no description"'
task raw_math_score: :environment do
  driver = ::Selenium::WebDriver.for :firefox

  puts "http://pisadataexplorer.oecd.org/ide/idepisa/report.aspx?p=1-RMS-1-20153-PVMATH-TOTAL-IN2,IN3,AUS,AUT,BEL,CAN,CHL,CZE,DNK,EST,FIN,FRA,DEU,GRC,HUN,ISL,IRL,ISR,ITA,JPN,KOR,LVA,LUX,MEX,NLD,NZL,NOR,POL,PRT,SVK,SVN,ESP,SWE,CHE,TUR,GBR,USA,ALB,QLB,DZA,QRG,BRA,QCH,BGR,ARG01,COL,CRI,HRV,QCY,DOM,MKD,GEO,HKG,IDN,JOR,KAZ,QAZ,KSV,LBN,LTU,MAC,MYS,QYS,MLT,MDA,MNE,PER,QAT,ROU,RUS,SGP,TAP,THA,TTO,TUN,ARE,URY,VNM-MN_MN-Y_J-0-0-37&Lang=1033..."
  driver.get "http://pisadataexplorer.oecd.org/ide/idepisa/report.aspx?p=1-RMS-1-20153-PVMATH-TOTAL-IN2,IN3,AUS,AUT,BEL,CAN,CHL,CZE,DNK,EST,FIN,FRA,DEU,GRC,HUN,ISL,IRL,ISR,ITA,JPN,KOR,LVA,LUX,MEX,NLD,NZL,NOR,POL,PRT,SVK,SVN,ESP,SWE,CHE,TUR,GBR,USA,ALB,QLB,DZA,QRG,BRA,QCH,BGR,ARG01,COL,CRI,HRV,QCY,DOM,MKD,GEO,HKG,IDN,JOR,KAZ,QAZ,KSV,LBN,LTU,MAC,MYS,QYS,MLT,MDA,MNE,PER,QAT,ROU,RUS,SGP,TAP,THA,TTO,TUN,ARE,URY,VNM-MN_MN-Y_J-0-0-37&Lang=1033"

  wait = Selenium::WebDriver::Wait.new(:timeout => 20)
  wait.until {driver.find_element(:css, "#rgReport_ctl00 tbody tr td").text}

  puts "finding rows..."
  rows = driver.find_elements(:css, "#rgReport_ctl00 tbody tr")

  puts "finding cells..."
  rows.each do |row|
    puts "scraping data..."
    name = row.find_element(:css, "th:nth-of-type(2)").text
    score = row.find_element(:css, "td:nth-of-type(1)").text

    if country = RawMathScore.find_by(country_name: name)
      puts "updating rank for existing country..."
      country.update(country_name: name, score: score, order: "desc")
    else
      puts "creating new country and score..."
      country = RawMathScore.create(country_name: name, score: score)
    end
  end

  puts "all done!"
  driver.quit
end
