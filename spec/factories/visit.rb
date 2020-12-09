FactoryBot.define do
  factory :visit do
    descripcion {Faker::Lorem.sentence }
    fecha { Faker::Date.backward(days: 1) }
    latitud { Faker::Address.latitude }
    longitud { Faker::Address.longitude }
    state_id { 1 }
  end

end