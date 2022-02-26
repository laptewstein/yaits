class Issue < ApplicationRecord
  belongs_to :discipline,     optional: true
  belongs_to :issue_priority, optional: true
  belongs_to :issue_status,   optional: true
  has_and_belongs_to_many :users

  alias_attribute :assignees, :users
  alias_attribute :priority,  :issue_priority
  alias_attribute :status,    :issue_status
end
