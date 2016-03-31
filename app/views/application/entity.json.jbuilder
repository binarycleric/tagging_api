json.entity do
  json.uuid @entity.id
  json.(@entity, :tags, :type, :created_at, :updated_at)
end
