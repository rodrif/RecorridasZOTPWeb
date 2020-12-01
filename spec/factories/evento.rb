FactoryBot.define do
  factory :evento do
    titulo { Faker::Alphanumeric.alpha(number: 10) }
    descripcion { Faker::Lorem.sentence }
    fecha_desde { Faker::Time.backward(days: 1) }
    fecha_hasta { Faker::Time.forward(days: 1) }
    ubicacion { Faker::Address.street_address }
  end
end
