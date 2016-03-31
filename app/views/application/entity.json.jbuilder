json.entity do
  json.uuid @entity.id
  json.tags @entity.tag_names
  json.(@entity, :created_at, :updated_at)
end
