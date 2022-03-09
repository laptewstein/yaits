Rails.application.routes.draw do
  resources :yaits, controller: 'issues', as: 'issues'
  root to: 'issues#index'
end