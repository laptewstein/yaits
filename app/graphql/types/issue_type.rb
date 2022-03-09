# frozen_string_literal: true

module Types
  class IssueType < Types::BaseObject
    field :id, ID, null: false
    field :created_at,  GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at,  GraphQL::Types::ISO8601DateTime, null: false
    field :title,       String, null: false
    field :description, String
    field :status,      Types::IssueStatusType
    field :discipline,  Types::DisciplineType
    field :assignees,   [Types::UserType]
    field :issue_priority_id, Integer
    field :issue_status_id,   Integer
    field :discipline_id,     Integer

    field :priority, Types::IssuePriorityType, null: true do
      argument :value, ID, required: false
    end

    def assignees
      object.assignees
    end

    def priority(**kwargs)
      return object.priority unless kwargs[:value]
      return object.priority unless object.priority.present?
      object.priority if object.priority.value < kwargs[:value].to_i.succ
    end
  end
end
