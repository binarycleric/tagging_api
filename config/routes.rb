Rails.application.routes.draw do

  put "/tags/:entity_type/:entity_id" => "tags#create",
    as: :create_tags, 
    defaults: {format: :json} 

  get "/tags/:entity_type/:entity_id" => "tags#show",
    defaults: {format: :json}

  delete "/tags/:entity_type/:entity_id" => "tags#destroy",
    defaults: {format: :json}

  get "/stats" => "stats#index",
    defaults: {format: :json}

  get "/stats/:entity_type/:entity_id" => "stats#show",
    defaults: {format: :json}
end
