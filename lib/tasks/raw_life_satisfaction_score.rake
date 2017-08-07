require 'csv'

desc "import happiness data from csv"
task happiness_data: :environment do
  CSV.foreach("happiness-data/2017-score.csv", headers: true) do |row|
    if country = RawLifeSatisfactionScore.find_by(country_name: row["Country"])
      puts "updating rank for existing country..."
      country.update(country_name: "raw_life_satisfaction_score", score: row["Happiness score"], order: "desc")
    else
      puts "creating new country and score..."
      RawLifeSatisfactionScore.create(country_name: row["Country"], score: row["Happiness score"], order: "desc")
    end
  end
end
