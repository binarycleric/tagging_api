require 'rails_helper'

RSpec.describe StatsController do
  render_views

  before do
    request.headers["accept"] = 'application/json'
  end

  describe "#index" do

    let(:expected_tags) do
      %w( iPhone Neat Fast Nifty A7 Mobile yolo swag MLG )
    end

    before do
      2.times.each do |n|
        Entity.new.tap do |e|
          e.type = "Test"
          e.tags = expected_tags 
          e.save!
        end
      end
    end

    it "displays stats about tags" do
      get :index

      tags = JSON.parse(response.body)["tags"]
      expect(tags).to be

      expect(tags.map{|t| t['name']}.sort).to eql expected_tags.sort
      expect(tags.map{|t| t['count']}.uniq).to eql [2] 
    end
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
    end

    it 'returns not_found for invalid entity' do
      get :show, {entity_id: SecureRandom.uuid, entity_type: "Product"}
      
      expect_missing_entity_json_response
    end

  end

end
