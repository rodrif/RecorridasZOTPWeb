FactoryBot.define do
  factory :area do
    nombre { Faker::Address.city }
    state_id { 1 }
  end
end