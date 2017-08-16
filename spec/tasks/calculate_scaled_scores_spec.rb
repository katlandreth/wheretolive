require "rails_helper"

RSpec.describe "rake calculate_scaled_scores", type: :task do

  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  it "runs gracefully with no subscribers" do
    expect { task.execute }.not_to raise_error
  end

  # it "logs to stdout" do
  #   expect { task.execute }.to output("Sending invoices\n").to_stdout
  # end

  # it "emails invoices" do
  #   subscriber = create(:subscriber)
  #
  #   task.execute
  #
  #   expect(subscriber).to have_received_invoice
  # end

  # it "checks in with Dead Mans Snitch" do
  #   dead_mans_snitch_request = stub_request(:get, "https://nosnch.in/c2354d53d2")
  #
  #   task.execute
  #
  #   expect(dead_mans_snitch_request).to have_been_requested
  # end

  # matcher :have_received_invoice do
  #   match_unless_raises do |subscriber|
  #     expect(last_email_sent).to be_delivered_to subscriber.email
  #     expect(last_email_sent).to have_subject 'Your invoice'
  #     ...
  #   end
  # end

end
