# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'projects/:project_id/builds', to: 'builds#index'
match 'projects/:project_id/builds/:id', to: 'builds#view', via: [:get, :post]
#resources :builds, :only => [:index, :new, :update]

get 'builds', to: 'builds#all'
post 'builds/new', to: 'builds#new'
match 'builds/:id', to: 'builds#update', via: [:get, :post]
