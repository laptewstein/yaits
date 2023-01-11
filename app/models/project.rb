class Project < ApplicationRecord
  # many to many
  has_and_belongs_to_many :employees, join_table: 'employee_projects'

  # many to one (many employees can have multiple projects)
  # has_one :employee_project
  # has_one :employee, through: :employee_project
end
