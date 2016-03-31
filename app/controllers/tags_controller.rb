class TagsController < ApplicationController

  ##
  # Uses PUT, since we are logically upserting. 
  def create
    # TODO: Temp. Working on API behaviors.
    if params[:entity_type] && params[:entity_id]
      entity = Entity.find_or_initialize_by id: params[:entity_id]
      entity.set_tags (params[:tags] || [])
      entity.save!
     
      location = create_tags_path entity_id: params[:entity_id],
                                  entity_type: params[:entity_type] 

      response.headers['Location'] = location 
      render status: :created, body: nil
      return
    else
      # TODO: Add specific message for errors.
      errors = {message: "Stuff is missing"}
      render status: :bad_request, body: errors
    end
  end

end
