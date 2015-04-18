json.array!(@locations) do |location|
  json.extract! location, :id, :latitud, :longitud, :fecha, :person_id
  json.url location_url(location, format: :json)
end
