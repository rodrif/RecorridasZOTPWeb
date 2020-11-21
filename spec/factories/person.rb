FactoryBot.define do
  factory :person do
    nombre { Faker::Name.first_name }
    apellido {Faker::Name.last_name }
    dni { 36000000 }
    fecha_nacimiento { Faker::Date.between(from: '1950-01-01', to: '2000-12-31') }
    telefono { Faker::Number.number(digits: 10) }
    pantalon { 'M' }
    remera { 'M' }
    zapatillas { '41' }
    descripcion { Faker::Lorem.sentence }
    zone { Zone.first }
    state_id { 1 }
  end


end