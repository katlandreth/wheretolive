require "rails_helper"

RSpec.describe ScrapeScores do

  it "creates a new country if one does not exist" do
    count = RawCostOfLivingScore.count
    scraper = ScrapeScores.new("RawCostOfLivingScore", "driver")
    scraper.record_data_for_country("Neverland", 1)

    expect(RawCostOfLivingScore.count).to eq(count + 1)
    expect(RawCostOfLivingScore.last.country_name).to eq("Neverland")
    expect(RawCostOfLivingScore.last.score).to eq(1.0)

  end

  it "updates a country if it exists" do
    count = RawCostOfLivingScore.count
    scraper = ScrapeScores.new("RawCostOfLivingScore", "driver")
    scraper.record_data_for_country("Neverland", 1)
    count = RawCostOfLivingScore.count

    scraper.record_data_for_country("Neverland", 20)

    expect(RawCostOfLivingScore.count).to eq(count)
    expect(RawCostOfLivingScore.last.country_name).to eq("Neverland")
    expect(RawCostOfLivingScore.last.score).to eq(20.0)

  end

end
