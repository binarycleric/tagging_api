module ControllerHelpers

  def expect_entity_json_response(entity)
    json_entity = JSON.parse(response.body)["entity"]

    expect(json_entity["uuid"]).to eql entity.id
    expect(json_entity["tags"]).to eql entity.tags
    expect(json_entity["type"]).to eql entity.type
    expect(json_entity["created_at"]).to be
    expect(json_entity["updated_at"]).to be
  end

end
