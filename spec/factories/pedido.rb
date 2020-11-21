FactoryBot.define do
  factory :pedido do
    descripcion {Faker::Lorem.sentence }
    fecha { Faker::Date.backward(days: 1) }
    completado { 0 }
    state_id { 1 }
  end

end