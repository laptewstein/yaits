class Employee < ApplicationRecord
  # belongs_to :discipline,     optional: true
  # belongs_to :issue_priority, optional: true
  # belongs_to :issue_status,   optional: true
  # has_and_belongs_to_many :users
end

# 1) all Projects employee is assigned to given employee_id
# 2) retrieve all employees in a department given department_id