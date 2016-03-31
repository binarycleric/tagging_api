class TagStatsController < ApplicationController

  def index
    @tags = Tag.all.preload(:entities)
  end

end
