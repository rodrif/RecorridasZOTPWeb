json.array!(@alerts) do |alert|
  json.extract! alert, :id, :mensaje, :fecha, :zone_id
  json.url alert_url(alert, format: :json)
end
