require 'rails_helper'

RSpec.describe ShortenUrlJob, type: :job do
  let(:user) { FactoryBot.build(:user, website_url: 'https://www.google.com') }

  it "shortens the user's website_url" do
    described_class.perform_now user
    expect(user.short_url).to include('https://cutt.ly/')
  end
end
