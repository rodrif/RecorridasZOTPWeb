json.extract! evento, :id, :titulo, :descripcion, :fecha_desde, :fecha_hasta, :ubicacion, :persona_id, :user_id, :created_at, :updated_at
json.url evento_url(evento, format: :json)
