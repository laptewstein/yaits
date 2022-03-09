module Types
  class QueryType < Types::BaseObject
    description "The query root of this schema"

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :disciplines, [Types::DisciplineType],    null: false, description: "Returns static list of all disciplines"
    field :statuses,    [Types::IssueStatusType],   null: false, description: "Returns static list of all statuses"
    field :priorities,  [Types::IssuePriorityType], null: false, description: "Returns static list of all priorities"
    field :users,       [Types::UserType],          null: false, description: "Returns static list of all users"
    field :issues,      [Types::IssueType],         null: false, description: "Returns static list of all issues"
    field :issue, Types::IssueType, "Find an issue by ID" do
      argument :id, ID
    end

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

    def issue(id:)
      Issue.find(id)
    end
  end
end
