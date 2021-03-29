require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'friendships' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }

    it 'is bi-directional' do
      user1.friends << user2

      expect(user1.friends).to include(user2)
      expect(user2.friends).to include(user1)
    end
  end
end
