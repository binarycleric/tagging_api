json.entity do
  json.uuid @entity.uuid
  json.tags @entity.tag_names
  json.(@entity, :type, :created_at, :updated_at)
end
