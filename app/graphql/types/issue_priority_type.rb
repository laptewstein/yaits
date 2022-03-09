# frozen_string_literal: true

module Types
  class IssuePriorityType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :label, String, null: false
    field :value, Integer, null: false
  end
end
