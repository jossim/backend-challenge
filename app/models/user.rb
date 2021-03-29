class User < ApplicationRecord
  include Clearance::User
  include PgSearch::Model

  pg_search_scope :search_by_website, against: :website_content

  has_and_belongs_to_many :friends,
                          class_name: "User",
                          foreign_key: "this_user_id",
                          association_foreign_key: "other_user_id",
                          after_add: :make_friendship_bi_directional

  def friendship_path_to(other_user, temp_list = [])
    temp_list << self

    if friends.include? other_user
      temp_list << other_user

      return temp_list
    else
      friends.each do |friend|
        friend.friendship_path_to(other_user, temp_list)
      end
    end

    temp_list
  end

  private

  def make_friendship_bi_directional(friend)
    friend.friends << self unless friend.friends.include?(self)
  end
end
