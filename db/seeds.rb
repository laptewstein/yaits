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
