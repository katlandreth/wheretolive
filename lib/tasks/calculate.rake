desc 'normalized ranks'
task calculate_normalized_ranks: :environment do

  puts "Time to make the doughnuts..."

  # ["cost_of_living_rank", "life_satisfaction_rank", "freedom_of_press_rank", "reading_rank", "math_rank", "science_rank"]
  attrs = Rank.pluck(:name)
  puts "Found the attributes:"
  puts attrs
  attrs.each do |attr|
    puts "Updating " + attr + "..."
    ranks = NormalizeData.new("country").normalized_category_ranks(attr, 1, 100)
    puts "Calculated the normalized ranks for " + attr
    ranks.each do |id, score|
      Rank.where(country_id: id).find_by(name: attr).update(normalized_score: score)
    end
  end
  puts "Done making doughnuts."
end
