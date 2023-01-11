disciplines = [
  "Engineering",
  "UX",
  "Analytics",
  "CS",
  "Marketing",
  "Finance",
  "Sales",
  "Investor Relations",
  "Strategic Partnerships",
]
statuses    = [
  "Open",
  "In progress",
  "In review",
  "Closed",
  "Reopened",
  "Wontfix",
]
priorities  = [
  ["P0", 0],
  ["P1", 1],
  ['High', 2],
  ['P2', 3],
  ['Medium', 4],
  ['Low', 5],
]
users       = [
  { name: 'CSAdmin',  email: 'csadmin@downtowncore.ca'  },
  { name: 'Oncall',   email: 'oncall@bigtech.ca'        },
  { name: 'WatchBot', email: 'watchbot@downtowncore.ca' },
  { name: 'IT-Desk',  email: 'desk@tinytech.com'        },
]

priorities.each { |k, v| IssuePriority.create(label: k, value: v) }
disciplines.each { |e| Discipline.create(label: e) }
statuses.each { |e| IssueStatus.crete(label: e) }
User.create(users)



departments = [ 'Transportation', 'Legal', 'Monitoring', 'Accounts']
projects = ['1M', '5M', '10M', '1B', '100M']
employees = [
  ['Steffany', 'St', 1 ],
  ['Valeria', 'Va', 1 ],
  ['Lindsay', 'Li', 2 ],
  ['Chelsea', 'Ch', 3 ]
]
employee_projects = [ [1, 1], [2,1], [2,2], [3,3], [4,4] ]

departments.each { |d| Department.create(name: d) }
