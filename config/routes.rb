Rails.application.routes.draw do

  resources :tags, only: [:create], defaults: {format: :json}

end
