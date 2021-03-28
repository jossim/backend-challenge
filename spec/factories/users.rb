websites = [
  'http://josephis.me/fish-test.html',
  'http://josephis.me/dog-test.html',
  'http://josephis.me/cat-test.html'
]

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    last_name { Faker::Name.last_name }
    first_name { Faker::Name.first_name }
    website_url { websites[Random.rand(websites.length - 1)] }
    password { 'password' }
  end
end
