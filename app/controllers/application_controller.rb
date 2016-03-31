class ApplicationController < ActionController::Base

  def self.handle_missing_entity
    rescue_from ActiveRecord::RecordNotFound do
      render status: :not_found, json: {
        error: {
          message: "Specified record not found",
          params: {entity_id: params[:entity_id],
                   entity_type: params[:entity_type]}
        }
      } 
    end
  end

end
