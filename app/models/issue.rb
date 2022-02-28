class Issue < ApplicationRecord
  belongs_to :discipline,     optional: true
  belongs_to :issue_priority, optional: true
  belongs_to :issue_status,   optional: true
  has_and_belongs_to_many :users

  alias_attribute :assignees, :users
  alias_attribute :priority,  :issue_priority
  alias_attribute :status,    :issue_status

  validate :title_present

  def title_present
    errors.add(:base, 'Title is required. Please shortly describe what this is about.') if title.blank?
  end
end
