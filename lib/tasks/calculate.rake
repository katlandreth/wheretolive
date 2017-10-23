desc 'linearly scale/normalize raw country scores'
task calculate_scaled_scores: :environment do

  puts "Time to make the doughnuts..."
  raw_tables = RAWSCORETABLES
  raw_tables.each do |table|
    attribute = NormalizeData.attribute_name_from_raw_table(table)

    scores = NormalizeData.new("country").normalized_category_scores(table.constantize.raw_score_order)
    scores.each do |raw_country_name, score|

      country_display_name = Country::Alias.country_display_name(raw_country_name)

      if country = Country.find_by(name: country_display_name)
        puts "updating " + country_display_name + " " + score.to_s
        country.update(attribute => score)
      else
        puts "creating " + country_display_name
        Country.create(attribute => score, name: country_display_name)
      end
    end
  end

  puts "Done making doughnuts."
end
