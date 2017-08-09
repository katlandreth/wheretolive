desc 'scale raw country scores'
task calculate_scaled_scores: :environment do

  puts "Time to make the doughnuts..."
  raw_tables = %w[RawReadingScore RawScienceScore RawMathScore RawLifeSatisfactionScore RawFreedomOfPressScore RawCostOfLivingScore]
  raw_tables.each do |table|
    scores = NormalizeData.new("country").normalized_category_ranks(table, table.constantize.raw_score_order)
    scores.each do |raw_country_name, score|
      if country = Country.find_by(name: country_display_name(raw_country_name))
        country.update(attribute_name(table) => score)
      else
        Country.create(attribute_name(table) => score, name: country_display_name(raw_country_name))
      end
    end
  end

  puts "Done making doughnuts."
end

def country_display_name(raw_country_name)
  CountryAlias.find_by(name: raw_country_name).display_name
end

def attribute_name(table)
  table.underscore.gsub("raw_", "").to_sym
end
