FactoryBot.define do
  factory :institucion do
    nombre { Faker::University.suffix }
    descripcion {Faker::Lorem.sentence }
    direccion { Faker::Address.street_address }
    contacto { Faker::Internet.email }
    telefono { Faker::Number.number(digits: 10) }
    codigo_postal { Faker::Address.zip_code }
    latitud { Faker::Address.latitude }
    longitud { Faker::Address.longitude }
    state_id { 1 }

    factory :merendero do
      institucion_tipo_id { 1 }
    end

    factory :colegio do
      institucion_tipo_id { 2 }
    end

    factory :universidad do
      institucion_tipo_id { 3 }
    end
  end


end