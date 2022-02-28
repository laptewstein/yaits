Rails.application.routes.draw do
  resources :issues
end


# require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
#
# patcher = Module.new do
#   extend ActiveSupport::Concern
#
#   included do
#     hook_for :resource_route, required: true
#   end
# end
#
# Rails::Generators::ScaffoldControllerGenerator.send :include, patcher