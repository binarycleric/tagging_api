json.tags(@tags) do |tag|
  json.id tag.id
  json.name tag.name
  json.count tag.entities.count
end
