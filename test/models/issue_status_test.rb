require 'test_helper'

class IssueStatusTest < ActiveSupport::TestCase
  test "Issue labels" do
    assert IssueStatus.all.count > 0
    assert IssueStatus.all.map(&:label).uniq.count == IssueStatus.all.count
  end
end
