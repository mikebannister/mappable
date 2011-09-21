Mappable::Engine.routes.draw do
  resources :maps, :path => "/"

  match "/:subject/:attr",
        to: 'mappings#index',
        as: 'mappings',
        via: 'get'

  match "/:subject/:attr",
        to: 'mappings#create',
        as: 'mappings',
        via: 'post'

  match "/:subject/:attr/new",
        to: 'mappings#new',
        as: 'new_mapping',
        via: 'get'

  match "/:subject/:attr/:id",
        to: 'mappings#show',
        as: 'mapping',
        via: 'get'

  resources :mappings, only: [:edit, :destroy]
end
