require 'rails_helper'

RSpec.describe TagsController do

  let(:uuid) { SecureRandom.uuid }

  describe "#create" do

    it "creates new tag" do
      params = {
        entity_type: 'Product',
        entity_id: uuid, 
        tags: ['Large', 'Pink', 'Bike']
      }
      post :create, params

      expect(response).to have_http_status :created
      expect(response.body).to be_empty
      expect(response.headers["Location"]).to be
    end

    it "returns bad request if params are missing" do
      post :create, {} 

      expect(response).to have_http_status :bad_request
      expect(response.body).to_not be_empty
      expect(response.headers["Location"]).to_not be
    end

  end

end
