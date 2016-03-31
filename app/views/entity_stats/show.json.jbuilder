json.tags(@entity_tags) do |et|
  json.uuid et.tag.uuid
  json.name et.tag.name
  json.added_at et.created_at
end
