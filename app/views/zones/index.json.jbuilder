json.array!(@zones) do |zone|
  json.extract! zone, :id, :nombre
  json.url zone_url(zone, format: :json)
end
