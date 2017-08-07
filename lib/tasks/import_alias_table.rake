require 'csv'

desc "import alias data from csv"
task alias_data: :environment do
  CSV.foreach("country_names-csv.csv", headers: true) do |row|
    if country_alias = CountryAlias.find_by(name: row["Name"])
      puts "updating #{row["Name"]}..."
      country_alias.update(name: row["Name"], display_name: row["preferred_name"])
    else
      puts "creating new #{row["Name"]}..."
      CountryAlias.create(name: row["Name"], display_name: row["preferred_name"])
    end
  end
end
