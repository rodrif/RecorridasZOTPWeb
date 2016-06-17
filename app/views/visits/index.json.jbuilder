json.array!(@visits) do |visit|
  json.extract! visit, :id, :descripcion, :fecha, :person_id, :latitud, :longitud
  json.url visit_url(visit, format: :json)
end
