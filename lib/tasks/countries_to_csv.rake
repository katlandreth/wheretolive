require 'csv'

namespace :export do
  desc "export country names to csv"
  task country_names: :environment do

    file = "#{Rails.root}/public/user_data.csv"
    countries = Country.all
    column_headers = ["Name", "ID"]

    CSV.open(file, 'w', write_headers: true, headers: column_headers) do |writer|
      countries.each do |country|
        writer << [country.name, country.id]
      end
    end
  end
end
