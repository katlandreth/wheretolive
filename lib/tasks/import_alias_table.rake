require 'csv'

desc "import alias data from csv - used after building the alias data in google refine"
task alias_data: :environment do
  CSV.foreach("country_names_aliases.csv", headers: true) do |row|
    if country_alias = CountryAlias.find_by(name: row["raw_name"])
      puts "updating #{row["raw_name"]}..."
      country_alias.update(name: row["raw_name"], display_name: row["preferred_name"])
    else
      puts "creating new #{row["raw_name"]}..."
      CountryAlias.create(name: row["raw_name"], display_name: row["preferred_name"])
    end
  end
end
