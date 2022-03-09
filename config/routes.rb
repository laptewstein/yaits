Rails.application.routes.draw do
  resources :yaits, controller: 'issues', as: 'issues'
  root to: 'issues#index'
  post "/graphql", to: "graphql#execute"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
end