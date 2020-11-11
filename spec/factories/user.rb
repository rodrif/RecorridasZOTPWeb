FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456789" }
    name { Faker::Name.first_name }
    apellido { Faker::Name.last_name }
    rol_id {2}

    factory :user_admin do
      rol_id {1}
    end
  end
end