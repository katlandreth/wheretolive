require 'csv'

namespace :export do
  desc "export country names to csv"
  task country_names: :environment do

    file = "#{Rails.root}/public/country_names.csv"
    raw_tables = %w[RawReadingScore RawScienceScore RawMathScore RawLifeSatisfactionScore RawFreedomOfPressScore RawCostOfLivingScore CountryCode]
    column_headers = ["Name", "ID"]

    CSV.open(file, 'w', write_headers: true, headers: column_headers) do |writer|
      raw_tables.each do |table|
        table.constantize.all.each do |country|
          writer << [country.country_name, country.id]
        end
      end
    end
  end
end
