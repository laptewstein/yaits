#### Unity Sample Issue Tracking Service

## TLDR
0. From within `make serve`, bootstrap the database with `bundle exec rake db:create db:migrate`. Exit.
1. From within the repo, `make up`.
3. Head to http://0.0.0.0:8888/issues.
4. Detach containers with `make down`. 

## Short Description, a living yet incomplete document
_YAITS_ is a containerized rails application. 
- It constitutues of a single [controller](https://github.com/Kartoshka548/yaits/blob/main/app/controllers/issues_controller.rb) exposing basic CRUD API [endpoints](https://github.com/Kartoshka548/yaits/blob/main/config/routes.rb#L2) and a few [databases tables](https://github.com/Kartoshka548/yaits/tree/main/db/migrate) for rails models such as [_Issue_](https://github.com/Kartoshka548/yaits/blob/main/app/models/issue.rb), [_Discipline_](https://github.com/Kartoshka548/yaits/blob/main/app/models/discipline.rb), [_Priority_](https://github.com/Kartoshka548/yaits/blob/main/app/models/issue_priority.rb), [_Status_](https://github.com/Kartoshka548/yaits/blob/main/app/models/issue_status.rb), and of course, the [_User_](https://github.com/Kartoshka548/yaits/blob/main/app/models/user.rb). 
- Note: `index` admin page filtering is **additive**, meaning that after a few clicks, we would have to start over.
- Currently we are supporting User signups only via the console.

> One user can be working on many issues, and _any_ issue can be assigned to _any_ active user.

Currently we do not _retain creator and reporter information_, even though we do have a [_many-to-many relationship_](https://github.com/Kartoshka548/yaits/blob/main/db/migrate/20220226040845_add_issues_to_users.rb) ties between `User` and `Issue` models. One way to keep this info tagging along is to create a "data" pocket (of key-value type storage), holding reporter and creator's tracks, or _maybe_ change the way how we retrieve issue [_assignees_](https://github.com/Kartoshka548/yaits/blob/main/app/models/issue.rb#L5-L7) from issue's associated _users_ which might (or might not) include the roles above. A hybrid between these two roadblocks is probably optimal going forward. 


## Task Overview
Unity desperately needs yet another issue tracking service (YAITS!) and has chosen you to design and
build the backend for it. Other developers should be able to use HTTP requests to invoke APIs that...

 - [x] [get a list of issues](https://github.com/Kartoshka548/yaits/blob/main/test/controllers/issues_controller_test.rb#L8-L11)
 - [x] [search issues](https://github.com/Kartoshka548/yaits/blob/main/spec/requests/issue_spec.rb) via attribute criteria matching (e.g. find issues of priority 7 or [higher](https://github.com/Kartoshka548/yaits/blob/main/app/controllers/issues_controller.rb#L132-L135))
 - [x] [create a new issue](https://github.com/Kartoshka548/yaits/blob/main/test/controllers/issues_controller_test.rb#L18-L23)
 - [x] [update an issue](https://github.com/Kartoshka548/yaits/blob/main/test/controllers/issues_controller_test.rb#L35-L38)
 - [x] [delete an issue](https://github.com/Kartoshka548/yaits/blob/main/test/controllers/issues_controller_test.rb#L40-L43)

[Issues](https://github.com/Kartoshka548/yaits/blob/main/app/models/issue.rb) should...
 - [x] be [unique](https://github.com/Kartoshka548/yaits/blob/main/db/migrate/20220225224318_create_issues.rb#L23)
 - [x] have a short description
 - [x] have a detailed description
 - [x] have a [priority](https://github.com/Kartoshka548/yaits/blob/main/db/migrate/20220225192053_create_issue_priorities.rb)
 - [x] have a [status](https://github.com/Kartoshka548/yaits/blob/main/db/migrate/20220225182236_create_issue_statuses.rb) (e.g. open, closed)
 - [x] be [assignable](https://github.com/Kartoshka548/yaits/blob/main/app/controllers/issues_controller.rb#L33) to a *[team member](https://github.com/Kartoshka548/yaits/issues/5)

Too easy? Feel free to also consider...
 -  [x] simple [frontend](https://github.com/Kartoshka548/yaits/tree/main/app/views) forms/pages to expose the APIs for end users
 -  [x] [tests](https://github.com/Kartoshka548/yaits/tree/main/test/fixtures)
 -  [x] deployment scripts/[tools](https://github.com/Kartoshka548/yaits/blob/main/Makefile#L9)
 -  [ ] authentication
 -  [ ] a system for inviting members into a team
 -  [ ] conditional access to a subset of issues by non-team members
 -  [ ] allowing members to comment on issues
 -  [ ] voting for issues

...or anything else that strikes your fancy.

When you're ready...
 - [ ] include a short description of your design, discussing any trade-offs/compromises, scale, or
performance issues, along with what the future might hold for extending your service,
 - [x] create a new git repository (or a similar shareable version control) at the start of your project,
make sensible check-ins throughout your project
 - [ ] zip up your repo (including the version control directory) and publish away.

#### Endpoints 
1. GET/POST Index `/issues(?...)`
![Screen Shot 2022-02-27 at 9 11 11 PM](https://user-images.githubusercontent.com/2070909/155913037-841b420a-0468-4c4e-aadb-9cdc75da8d80.png)

2. GET New `/issues/new`
![Screen Shot 2022-02-27 at 9 11 27 PM](https://user-images.githubusercontent.com/2070909/155913049-be2bc65c-c5fb-43b2-a9a1-729dea1aa58f.png)

3. GET/PATCH/PUT Edit `/issues/<id>/edit`
![Screen Shot 2022-02-27 at 9 11 46 PM](https://user-images.githubusercontent.com/2070909/155913065-80512a7a-30d3-4047-8789-f2b4ac079fbb.png)

4. GET Show `/issues/<id>`
![Screen Shot 2022-02-27 at 9 12 02 PM](https://user-images.githubusercontent.com/2070909/155913137-02ded449-6217-453a-91ef-239904846e8a.png)

5. DELETE `/issues/<id>`

#### Useful commands (along the Makefile)
1. log into container: `make serve` 
2. mysql db: `bundle exec rails db`
3. testing: `bundle exec rails test`
4. testing (rspec): `bundle exec rspec`
5. sample initial Priorities, Statuses and Disciplines: 
```
[["P0", 0], ["P1", 1], ['High', 2],['P2', 3],['Medium', 4],['Low', 5]].each { |k, v| IssuePriority.new(label: k, value: v).save }
["Engineering", "UX", "Analytics", "CS", "Marketing", "Finance", "Sales"].each { |e| Discipline.new(label: e).save }
["Open", "In progress", "In review", "Closed", "Reopened", "Wontfix"].each { |e| IssueStatus.new(label: e).save }
```
#### Project Routes
```
bundle exec rails routes
 === Prefix   Verb      URI Pattern                   Controller#Action ===
     issues   GET       /issues(.:format)             issues#index
              POST      /issues(.:format)             issues#create
  new_issue   GET       /issues/new(.:format)         issues#new
 edit_issue   GET       /issues/:id/edit(.:format)    issues#edit
      issue   GET       /issues/:id(.:format)         issues#show
              PATCH     /issues/:id(.:format)         issues#update
              PUT       /issues/:id(.:format)         issues#update
              DELETE    /issues/:id(.:format)         issues#destroy
```
