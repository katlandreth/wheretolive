require "rails_helper"

RSpec.describe FilterAndSort do

  it "calculates a default overall score excluding countries with not data" do
    data = FilterAndSort.new.weighted_scores
    expect(data).not_to include(:value => nil)
  end

  it "calculates a weighted overall score" do
    weight_params_hash = {education_score_value: 1}.with_indifferent_access

    data = FilterAndSort.new(weight_params: weight_params_hash).weighted_scores
    expect(data.find{|country| country[:name] == 'Holy See'}).to include(:value => 0)
  end

end
