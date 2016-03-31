require 'rails_helper'

RSpec.describe TagsController do

  let(:uuid) { SecureRandom.uuid }

  describe "#create" do

    let(:params) do
      {
        entity_type: 'Product',
        entity_id: uuid, 
        tags: ['Large']
      }
    end 

    it "creates new tag" do
      put :create, params

      entity = Entity.find_by(id: uuid)
      expect(entity).to be
      expect(entity.tags.map(&:name)).to eql ["Large"]
    end

    it "returns create HTTP status with resource location" do
      uri_pattern = /\/tags\/#{params[:entity_type]}\/#{params[:entity_id]}$/ 

      put :create, params

      expect(response).to have_http_status :created
      expect(response.body).to be_empty
      expect(response.headers["Location"]).to match(uri_pattern) 
    end

  end

end
