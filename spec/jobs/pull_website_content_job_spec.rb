require 'rails_helper'

RSpec.describe PullWebsiteContentJob, type: :job do
  let(:user) { FactoryBot.build(:user, website_url: 'http://localhost:3000/dog-test.html') }

  it "gets the headings from a user's website" do
    described_class.perform_now user

    content = [
      "The value of dog", "The number of dog in the world", "How to play games with dog"
    ].join("\n")

    expect(user.website_content).to eq content
  end

  it "logs errors" do
    user.website_url = "http://null.example.com/"

    described_class.perform_now user

    expect(user.website_content).to eq "Request to URL failed, no content"
  end
end
