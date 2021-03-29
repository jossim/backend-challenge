class UsersUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users_users, id: false do |t|
      t.integer :this_user_id
      t.integer :other_user_id
    end
  end
end
