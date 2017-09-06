require 'csv'

namespace :export do
  desc "export all existing country names to csv - used when creating country name aliases"
  task country_names: :environment do

    file = "#{Rails.root}/country_names.csv"
    raw_tables = %w[RawReadingScore RawScienceScore RawMathScore RawLifeSatisfactionScore RawFreedomOfPressScore RawCostOfLivingScore CountryCode CountryPopulation CountryPopulationDensity]
    column_headers = ["raw name", "preferred_name"]

    CSV.open(file, 'w', write_headers: true, headers: column_headers) do |writer|
      raw_tables.each do |table|
        table.constantize.all.each do |country|

          # below we fill in the country's preferred name, or the current name of the attribute to make this column useful for clustering in OpenRefine
          preferred_name = CountryAlias.find_by(name: country.country_name).try(:display_name) || country.country_name
          writer << [country.country_name, preferred_name]
        end
      end
    end
  end
end
