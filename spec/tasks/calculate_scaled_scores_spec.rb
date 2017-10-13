require "rails_helper"

RSpec.describe "rake calculate_scaled_scores", type: :task do

  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end
end
