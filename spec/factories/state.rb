FactoryBot.define do
  factory :state do

    trait :activo do
      nombre { "Actualizado" }
      id { 1 }
    end

    trait :borrado do
      nombre { "Borrado" }
      id { 3 }
    end
  end
end