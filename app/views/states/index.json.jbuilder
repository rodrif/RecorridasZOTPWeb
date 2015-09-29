json.array!(@states) do |state|
  json.extract! state, :id, :nombre
  json.url state_url(state, format: :json)
end
