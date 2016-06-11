json.array!(@familias) do |familia|
  json.extract! familia, :id, :nombre, :area_id, :zone_id, :ranchada_id, :descripcion
  json.url familia_url(familia, format: :json)
end
