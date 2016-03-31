class EntityStatsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render status: :not_found, json: {
      error: {
        message: "Specified record not found",
        params: {entity_id: params[:entity_id],
                 entity_type: params[:entity_type]}
      }
    } 
  end

  def show
    @entity = Entity.find params[:entity_id]
    @entity_tags = @entity.entity_tags
  end

end
