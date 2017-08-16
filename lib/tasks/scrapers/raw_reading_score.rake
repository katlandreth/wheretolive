namespace :scrape do
  desc 'scrape reading score data from OECD'
  task raw_reading_score: :environment do
    driver = ::Selenium::WebDriver.for :firefox

    scraper = ScrapeScores.new("RawReadingScore", driver)

    scraper.visit("http://pisadataexplorer.oecd.org/ide/idepisa/report.aspx?p=1-RMS-1-20153-PVREAD-TOTAL-IN2,IN3,AUS,AUT,BEL,CAN,CHL,CZE,DNK,EST,FIN,FRA,DEU,GRC,HUN,ISL,IRL,ISR,ITA,JPN,KOR,LVA,LUX,MEX,NLD,NZL,NOR,POL,PRT,SVK,SVN,ESP,SWE,CHE,TUR,GBR,USA,ALB,QLB,DZA,QRG,BRA,QCH,BGR,ARG01,COL,CRI,HRV,QCY,DOM,MKD,GEO,HKG,IDN,JOR,KAZ,QAZ,KSV,LBN,LTU,MAC,MYS,QYS,MLT,MDA,MNE,PER,QAT,ROU,RUS,SGP,TAP,THA,TTO,TUN,ARE,URY,VNM-MN_MN-Y_J-0-0-37&Lang=1033")
    scraper.wait_to_find("#rgReport_ctl00 tbody tr td")
    scraper.find_rows_by("#rgReport_ctl00 tbody tr")
    scraper.find_cells_by("th:nth-of-type(2)", "td:nth-of-type(1)")
    scraper.quit

  end
end
