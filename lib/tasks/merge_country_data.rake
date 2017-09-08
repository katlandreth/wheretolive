desc 'merge non-score country data from scrapes tables into appropriate Country row'
task merge_country_data: :environment do

  puts "Time to make the doughnuts..."
  tables = RAWCOUNTRYDATATABLES
  tables.each do |table|
    attribute = NormalizeData.attribute_name_from_country_data_table(table)
    table.constantize.all.each do |raw_country|
      raw_country_name = raw_country.country_name
      country_display_name = CountryAlias.country_display_name(raw_country_name)
      value = raw_country.value
      if country = Country.find_by(name: country_display_name)
        puts "updating " + country_display_name + " " + value.to_s
        country.update(attribute => value)
      else
        puts "creating " + " " + country_display_name
        Country.create(attribute => value, name: country_display_name)
      end
    end
  end

  puts "Done making doughnuts."
end
