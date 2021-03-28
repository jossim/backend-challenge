websites = [
  'http://localhost:3000/fish-test.html',
  'http://localhost:3000/dog-test.html',
  'http://localhost:3000/cat-test.html'
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
