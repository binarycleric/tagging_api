class TagsController < ApplicationController

  ##
  # TODO: Failure cases.
  def show
    # NOTE: Since we're using UUIDs for the entity's primary key, we don't need
    #       to do anything with :entity_type. The joys of using UUIDs. :) 
    @entity = Entity.find_by id: params[:entity_id]
    render "entity"
  end

  ##
  # Uses PUT, since we are logically upserting. 
  def create
    @entity = Entity.find_or_initialize_by id: params[:entity_id]
    @entity.tags = (params[:tags] || [])
    @entity.type = params[:entity_type]
    @entity.save!
   
    location = create_tags_path entity_id: params[:entity_id],
                                entity_type: params[:entity_type] 

    response.headers['Location'] = location 
    render "entity", status: :created
  end

  def destroy
    @entity = Entity.find_by id: params[:entity_id]
    @entity.destroy

    render status: :no_content, nothing: true
  end

end
