FactoryBot.define do
  factory :notificacion do
    titulo { Faker::Alphanumeric.alpha(number: 10) }
    subtitulo { Faker::Lorem.sentence }
    descripcion { Faker::Lorem.sentence }
    fecha_desde { DateTime.now.advance(hours: 2) }
    fecha_hasta { DateTime.now.advance(hours: 3) }
    frecuencia_cant { 1 }
    state_id { 1 }
    finalizada { 0 }

    factory :notificacion_unica do
      frecuencia_tipo_id { FrecuenciaTipo::UNICA }
    end

    factory :notificacion_diaria do
      frecuencia_tipo_id { FrecuenciaTipo::DIA }
    end
  end
end
