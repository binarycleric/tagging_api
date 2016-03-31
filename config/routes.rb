Rails.application.routes.draw do

  # resources :tags, only: [:create], defaults: {format: :json}
  put "/tags/:entity_type/:entity_id" => "tags#create",
    as: :create_tags, 
    defaults: {format: :json} 

  get "/tags/:entity_type/:entity_id" => "tags#show",
    defaults: {format: :json}


end
