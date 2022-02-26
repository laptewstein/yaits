require 'test_helper'

class IssuePriorityTest < ActiveSupport::TestCase
  test "Issue priority labels" do
    assert IssuePriority.all.count > 0
    assert IssuePriority.all.map(&:label).uniq.count == IssuePriority.all.count
  end
end
