FactoryBot.define do
  factory :area do
    nombre { Faker::Alphanumeric.alpha(number: 10) }
    state_id { 1 }
  end
end