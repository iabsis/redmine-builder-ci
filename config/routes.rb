# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'projects/:project_id/builds', to: 'builds#index'
get 'projects/:project_id/builds/:id', to: 'builds#view'
post 'builds/new', to: 'builds#new'