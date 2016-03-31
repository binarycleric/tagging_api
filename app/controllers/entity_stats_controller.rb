class EntityStatsController < ApplicationController
  handle_missing_entity

  def show
    @entity = Entity.find_typed_entity uuid: params[:entity_id],
                                       type: params[:entity_type]
    @entity_tags = @entity.entity_tags.preload(:tag)
  end

end
