json.stats do
  json.tags(@tags) do |tag|
    json.uuid tag.uuid
    json.name tag.name
    json.records_tagged tag.entities.count
    json.added_at tag.created_at   
  end
end
