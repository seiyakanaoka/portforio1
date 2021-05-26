FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    telephone_number { '00000000000' }
    password { 'password' }
    password_confirmation { 'password' }
    nick_name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 10) }
    profile_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sea-view12.jpg')) }
    license_rank { Faker::Lorem.characters(number: 10) }
  end
end
