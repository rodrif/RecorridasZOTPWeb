FactoryBot.define do
  factory :rol do
    puede_crear_persona { 0 }
    puede_editar_persona { 0 }
    puede_borrar_persona { 0 }
    puede_ver_telefono_persona { 0 }
    puede_ver_web { 0 }
    puede_crear_visita { 0 }
    puede_editar_visita { 0 }
    puede_borrar_visita { 0 }
    code { 5 }

    trait :admin do
      puede_crear_persona { 1 }
      puede_editar_persona { 1 }
      puede_borrar_persona { 1 }
      puede_ver_telefono_persona { 1 }
      puede_ver_web { 1 }
      puede_crear_visita { 1 }
      puede_editar_visita { 1 }
      puede_borrar_visita { 1 }
      code { 1 }
    end
  end
end