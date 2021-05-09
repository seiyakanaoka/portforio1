FactoryBot.define do
  factory :log do
    log_image { 'assets/images/sea-view12' }
    weather { 0 }
    dive_depth { 0 }
    dive_number { 0 }
    dive_point{ 0 }
    water_temperature { 0 }
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 100) }
    user
  end
end