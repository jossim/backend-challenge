require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let(:user3) { FactoryBot.create(:user) }
  let(:user4) { FactoryBot.create(:user) }
  let(:user5) { FactoryBot.create(:user) }

  describe 'friendships' do
    it 'is bi-directional' do
      user1.friends << user2

      expect(user1.friends).to include(user2)
      expect(user2.friends).to include(user1)
    end
  end

  describe 'friendship path' do
    it "finds a friendship path when there's one user between" do
      user1.friends << user2
      user2.friends << user3

      expect(user1.friendship_path_to(user3)).to eq [user1, user2, user3]
    end

    it "finds a friendship path when there's more than one user between" do
      # user1 > user2 > user3 > user4
      user1.friends << user2
      user2.friends << user3
      user3.friends << user4

      expect(user1.friendship_path_to(user4)).to eq [user1, user2, user3, user4]
    end

    it "finds a friendship path when there are dead ends" do
      # user1 > user2 > user4
      # user1 > user3 > user5
      user1.friends << user2
      user1.friends << user3
      user2.friends << user4
      user3.friends << user5

      expect(user1.friendship_path_to(user5)).to eq [user1, user3, user5]
    end
  end
end
