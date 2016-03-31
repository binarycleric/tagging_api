class TagsController < ApplicationController
  handle_missing_entity

  ##
  # NOTE: Since we're using UUIDs for the entity's primary key, we don't need
  #       to do anything with :entity_type. The joys of using UUIDs. :) 
  def show
    @entity = Entity.find_typed_entity uuid: params[:entity_id],
                                       type: params[:entity_type]
    render "entity"
  end

  ##
  # Uses PUT, since we are logically upserting. 
  def create
    @entity = Entity.create_typed_entity uuid: params[:entity_id],
                                         type: params[:entity_type],
                                         tags: (params[:tags] || [])

    location = create_tags_path entity_id: params[:entity_id],
                                entity_type: params[:entity_type] 

    response.headers['Location'] = location 
    render "entity", status: :created
  end

  def destroy
    @entity = Entity.find_typed_entity uuid: params[:entity_id],
                                       type: params[:entity_type]
    @entity.destroy

    render status: :no_content, nothing: true
  end

end
