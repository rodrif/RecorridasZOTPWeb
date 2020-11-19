FactoryBot.define do
  factory :visit do
    descripcion {Faker::Lorem.sentence }
    fecha { Faker::Date.backward(days: 1) }
    latitud { Faker::Address.latitude }
    longitud { Faker::Address.longitude }
    direccion { Faker::Address.street_address }
    state_id { 1 }
  end

end