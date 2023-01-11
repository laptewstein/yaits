class Employee < ApplicationRecord
  belongs_to :department, optional: true

  # retrieve all employees in a department given department_id
  scope :by_department, ->(department) { where(department: department) }

  # all Projects employee is assigned to given employee_id
  #----
  # many to many (many employees can have many shared projects)
  has_and_belongs_to_many :projects, join_table: 'employee_projects'
  #----
  # one to many as table name implies
  # has_many :employee_projects
  # alias :projects :employee_projects
end


