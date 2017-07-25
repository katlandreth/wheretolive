require 'csv'

namespace :import do
  desc "import happiness data from csv"
  task happiness_data: :environment do
    CSV.foreach("happiness-data/2017-score.csv", headers: true) do |row|
      if country = Country.find_by(name: row["Country"])
        if record = country.ranks.find_by(name: "life_satisfaction_rank")
          record.update(name: "life_satisfaction_rank", score: row["Happiness score"], order: "desc")
        else
          country.ranks.create(name: "life_satisfaction_rank", score: row["Happiness score"], order: "desc")
        end
      else
        country = Country.create(name: row["Country"]).ranks.create(name: "life_satisfaction_rank", score: row["Happiness score"], order: "desc")
      end
    end
  end
end
