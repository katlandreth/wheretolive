Country.all.each do |c|
  puts "{ name: '#{c.name}', code: '#{c.country_code}', col: '#{c.cost_of_living_score}' }"
end; nil
