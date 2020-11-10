FactoryBot.define do
  factory :area do
    nombre { Faker::Name.first_name }
    state_id { 1 }
  end
end