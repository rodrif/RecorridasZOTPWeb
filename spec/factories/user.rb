FactoryBot.define do
  factory :user do
    apellido { "admin" }
    email { Faker::Internet.email }
    uid { email }
    password { "123456789" }
    provider { "email" }
    rol

    trait :admin do
      association :rol, :admin
    end
  end
end