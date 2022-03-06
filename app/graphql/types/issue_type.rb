# frozen_string_literal: true

module Types
  class IssueType < Types::BaseObject
    field :id, ID, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :title, String, null: false
    field :description, String

    field :priority, Types::IssuePriorityType
    field :status, Types::IssueStatusType
    field :discipline, Types::DisciplineType
    field :assignees, [Types::UserType]

    # field :issue_priority_id, Integer
    # field :issue_status_id, Integer
    # field :discipline_id, Integer

    def assignees
      object.assignees
    end
  end
end
