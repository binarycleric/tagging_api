class TagsController < ApplicationController

  def create
    # TODO: Temp. Working on API behaviors.
    if params[:entity_type] && params[:entity_id] && params[:tags]
      # Stub.
      response.headers['Location'] = '/tags/11111/11111'
      render status: :created, body: nil
    else
      # TODO: Add specific message for errors.
      errors = {message: "Stuff is missing"}
      render status: :bad_request, body: errors
    end
  end

end
