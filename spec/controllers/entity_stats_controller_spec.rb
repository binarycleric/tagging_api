require 'rails_helper'

RSpec.describe EntityStatsController do
  render_views

  before do
    request.headers["accept"] = 'application/json'
  end

  describe "#show" do
    let(:expected_tags) do
      %w( iPhone Neat Fast Nifty A7 Mobile yolo swag MLG )
    end

    let(:entity) do
      Entity.new.tap do |e|
        e.type = "Test"
        e.tags = expected_tags 
        e.save!
      end
    end

    it "displays stats about tags" do
      get :show, {entity_id: entity.id, entity_type: entity.type}

      tags = JSON.parse(response.body)["tags"]
      expect(tags).to be

      expect(tags.map{|t| t['name']}.sort).to eql expected_tags.sort
      expect(tags.first["added_at"]).to be
    end

    it 'returns not_found for invalid entity' do
      get :show, {entity_id: SecureRandom.uuid, entity_type: "Product"}
      
      expect_missing_entity_json_response
    end
  end

end
