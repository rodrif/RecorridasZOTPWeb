FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "123456789" }
    name { Faker::Name.first_name }
    apellido { Faker::Name.last_name }
    confirmed_at {Faker::Date.backward(days: 14)}
    rol_id {5}

    factory :user_admin do
      rol_id {1}
    end

    factory :user_referente do
      rol_id {2}
    end

    factory :user_coordinador do
      rol_id {3}
    end

    factory :user_voluntario do
      rol_id {4}
    end

    factory :user_invitado do
      rol_id {5}
    end
  end
end