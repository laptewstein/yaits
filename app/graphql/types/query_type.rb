module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :disciplines, [Types::DisciplineType], null: false, description: "Returns static list of all disciplines"
    field :statuses, [Types::IssueStatusType], null: false, description: "Returns static list of all statuses"
    field :priorities, [Types::IssuePriorityType], null: false, description: "Returns static list of all priorities"
    field :users, [Types::UserType], null: false, description: "Returns static list of all users"
    field :issues, [Types::IssueType], null: false, description: "Returns static list of all issues"

    def disciplines
      Discipline.all
    end

    def statuses
      IssueStatus.all
    end

    def priorities
      IssuePriority.all
    end

    def users
      User.all
    end

    def issues
      Issue.all
    end
  end
end
