Rails.application.routes.draw do
  root 'welcome#index'

  get '/shelters', to: 'shelters#index'
end
