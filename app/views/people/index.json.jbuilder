json.array!(@people) do |person|
  json.extract! person, :id, :nombre, :apellido, :state_id, :zone_id, :updated_at
end
