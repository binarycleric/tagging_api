json.tags(@tags) do |tag|
  json.uuid tag.uuid
  json.name tag.name
  json.count tag.entities.count
end
