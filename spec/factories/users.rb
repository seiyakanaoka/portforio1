FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    telephone_number { '00000000000' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end