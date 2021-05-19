FactoryBot.define do
  factory :log do
    log_image { 'spec/fixtures/sea-view12.jpg' }
    weather { 0 }
    dive_depth { 0 }
    dive_number { 0 }
    dive_point{ 0 }
    water_temperature { 0 }
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 100) }
    address { Faker::Lorem.characters(number: 20) }
    hashbody { Faker::Lorem.characters(number: 10) }
    impressions_count { 0 }
    latitude { 0 }
    longitude { 0 }
    user
  end
end