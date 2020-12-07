FactoryBot.define do
  factory :zone do
    nombre { Faker::Alphanumeric.alpha(number: 10) }
    latitud { Faker::Address.latitude}
    longitud { Faker::Address.longitude}
    area_id { 1 }
    state_id { 1 }
  end
end