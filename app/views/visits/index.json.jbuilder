json.array!(@visits) do |visit|
  json.extract! visit, :id, :descripcion, :fecha, :person_id, :location_id
  json.url visit_url(visit, format: :json)
end
