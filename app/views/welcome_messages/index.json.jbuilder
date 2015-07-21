json.array!(@welcome_messages) do |welcome_message|
  json.extract! welcome_message, :id, :mensaje, :fecha_desde, :fecha_hasta, :person_id
  json.url welcome_message_url(welcome_message, format: :json)
end
