Rails.application.routes.draw do
  resources :yaits, controller: 'issues', as: 'issues'
end