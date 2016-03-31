class StatsController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render status: :not_found, json: {
      error: {
        message: "Specified record not found",
        params: {entity_id: params[:entity_id],
                 entity_type: params[:entity_type]}
      }
    } 
  end

  def index
    @tags = Tag.all.preload(:entities)
  end

  def show
    @entity = Entity.find params[:entity_id]
    @tags = @entity.entity_tags.map(&:tag)

    render "index"
  end

end
