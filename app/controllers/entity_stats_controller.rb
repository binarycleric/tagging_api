class EntityStatsController < ApplicationController
  handle_missing_entity

  def show
    @entity = Entity.find params[:entity_id]
    @entity_tags = @entity.entity_tags
  end

end
