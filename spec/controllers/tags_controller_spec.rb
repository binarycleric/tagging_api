require 'rails_helper'

RSpec.describe TagsController do
  render_views

  before do
    request.headers["accept"] = 'application/json'
  end

  let(:uuid) { SecureRandom.uuid }
  let(:entity) do
    Entity.new(id: uuid).tap do |entity|
      entity.set_tags %w( Neat Fast Apple )
      entity.type = "iPhone"
      entity.save!
    end
  end

  describe "#show" do
    it 'returns entity when requested' do
      get :show, {entity_id: entity.id, entity_type: entity.type}
      expect_entity_json_response(entity)
    end
  end

  describe "#create" do
    let(:uri_pattern) {
      /\/tags\/#{params[:entity_type]}\/#{params[:entity_id]}$/
    } 

    let(:params) do
      {
        entity_type: 'Product',
        entity_id: uuid, 
        tags: %w( Large ),
      }
    end 

    it "creates new tag in database" do
      put :create, params

      entity = Entity.find(uuid)
      expect(entity.tag_names).to eql %w( Large )
    end

    it "returns create HTTP status with resource location" do
      put :create, params

      expect(response).to have_http_status :created
      expect(response.headers["Location"]).to match(uri_pattern) 
    end

    it "returns JSON representation of entity" do
      put :create, params

      entity = Entity.find(uuid)
      expect_entity_json_response(entity)
    end
  end

  describe "#destroy" do
    it "deletes entity" do
      delete :destroy, {entity_type: entity.type, entity_id: entity.id}

      expect(response).to have_http_status :no_content
    end
  end

end
