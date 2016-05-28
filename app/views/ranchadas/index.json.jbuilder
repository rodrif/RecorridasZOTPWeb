json.array!(@ranchadas) do |ranchada|
  json.extract! ranchada, :id, :nombre, :area_id, :zone_id, :descripcion, :latitud, :longitud
  json.url ranchada_url(ranchada, format: :json)
end
