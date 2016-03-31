module ControllerHelpers

  def expect_missing_entity_json_response
    payload = JSON.parse(response.body)["error"]
   
    expect(response).to have_http_status :not_found
    expect(payload["message"]).to be
    expect(payload["params"]).to be
  end

  def expect_entity_json_response(entity)
    json_entity = JSON.parse(response.body)["entity"]

    expect(json_entity["uuid"]).to eql entity.id
    expect(json_entity["tags"].sort).to eql entity.tag_names.sort
    expect(json_entity["type"]).to eql entity.type
    expect(json_entity["created_at"]).to be
    expect(json_entity["updated_at"]).to be
  end

end
