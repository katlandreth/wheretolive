require "rails_helper"

RSpec.describe Country do
  it { should validate_presence_of(:name) }
end