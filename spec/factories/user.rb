FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456789" }
    name { Faker::Name.first_name }
    apellido { Faker::Name.last_name }
    rol_id { 5 }
    state_id { 1 }

    factory :user_admin do
      confirmed_at {Faker::Date.backward(days: 14)}
      rol_id {1}
    end

    factory :user_referente do
      confirmed_at {Faker::Date.backward(days: 14)}
      rol_id {2}
    end

    factory :user_coordinador do
      confirmed_at {Faker::Date.backward(days: 14)}
      rol_id {3}
    end

    factory :user_voluntario do
      confirmed_at {Faker::Date.backward(days: 14)}
      rol_id {4}
    end

    factory :user_invitado do
      rol_id {5}
    end
  end
end