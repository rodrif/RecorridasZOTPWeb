FactoryBot.define do
  factory :evento do
    titulo { Faker::Alphanumeric.alpha(number: 10) }
    descripcion { Faker::Lorem.sentence }
    fecha_desde { DateTime.now.advance(hours: 1) }
    fecha_hasta { DateTime.now.advance(hours: 2) }
    ubicacion { Faker::Address.street_address }
  end
end
