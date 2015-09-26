json.array!(@people) do |person|
  json.extract! person, :id, :nombre, :apellido, :zone_id, :updated_at
end
