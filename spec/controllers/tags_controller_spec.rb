require 'rails_helper'

RSpec.describe TagsController do
  render_views

  before do
    request.headers["accept"] = 'application/json'
  end

  let(:uuid) { SecureRandom.uuid }

  describe "#show" do

    before do
      entity = Entity.new(id: uuid)
      entity.set_tags %w( Neat Fast Apple )
      entity.save!
    end

    it 'returns entity when requested' do
      get :show, {entity_id: uuid, entity_type: "Product"}

      entity = JSON.parse(response.body)["entity"]

      expect(entity["uuid"]).to eql uuid
      expect(entity["tags"]).to eql %w( Neat Fast Apple )
      expect(entity["created_at"]).to be
      expect(entity["updated_at"]).to be
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

      json_entity = JSON.parse(response.body)["entity"]
      expect(json_entity).to be
      expect(json_entity["uuid"]).to be
      expect(json_entity["created_at"]).to be
      expect(json_entity["updated_at"]).to be
      expect(json_entity["tags"]).to be_kind_of(Array)
    end

  end

end
