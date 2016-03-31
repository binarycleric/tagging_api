class ApplicationController < ActionController::Base

  rescue_from StandardError do |error|
    Rails.logger.fatal "Something really bad happened. error: #{error.class} message: #{error.message}"
    
    if Rails.env.development?
      raise error
    else
      render status: :not_found, json: {
        error: {
          message: "That wasn't supposed to happen. We'll get that fixed as soon as we can!", 
        }
      }
    end
  end 

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
