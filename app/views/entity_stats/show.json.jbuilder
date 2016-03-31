json.tags(@entity_tags) do |et|
  json.id et.tag.id
  json.name et.tag.name
  json.added_at et.created_at
end
