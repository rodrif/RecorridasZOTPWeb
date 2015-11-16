json.array!(@referentes) do |referente|
  json.extract! referente, :id, :nombre, :apellido, :telefono, :area_id, :dia
  json.url referente_url(referente, format: :json)
end
