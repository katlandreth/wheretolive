require "rails_helper"

RSpec.describe ScrapeScores do

  it "creates a new country if one does not exist" do
    count = RawScores::RawCostOfLivingScore.count
    scraper = ScrapeScores.new("RawScores::RawCostOfLivingScore", "driver")
    scraper.record_data_for_country("Neverland", 1)

    expect(RawScores::RawCostOfLivingScore.count).to eq(count + 1)
    expect(RawScores::RawCostOfLivingScore.last.country_name).to eq("Neverland")
    expect(RawScores::RawCostOfLivingScore.last.score).to eq(1.0)

  end

  it "updates a country if it exists" do
    count = RawScores::RawCostOfLivingScore.count
    scraper = ScrapeScores.new("RawScores::RawCostOfLivingScore", "driver")
    scraper.record_data_for_country("Neverland", 1)
    count = RawScores::RawCostOfLivingScore.count

    scraper.record_data_for_country("Neverland", 20)

    expect(RawScores::RawCostOfLivingScore.count).to eq(count)
    expect(RawScores::RawCostOfLivingScore.last.country_name).to eq("Neverland")
    expect(RawScores::RawCostOfLivingScore.last.score).to eq(20.0)

  end

end
