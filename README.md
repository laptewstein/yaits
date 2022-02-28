#### Unity Sample Issue Tracking Service

## TLDR
0. From within `make serve`, bootstrap the database with `bundle exec rake db:create db:migrate`. Exit.
1. From within the repo, `make up`.
3. Head to http://0.0.0.0:8888/issues.
4. Detach containers with `make down`. 

## Overview
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
 - [x] be [assignable](https://github.com/Kartoshka548/yaits/blob/main/app/models/user.rb#L2) to a *[team member](https://github.com/Kartoshka548/yaits/issues/5)

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

GET/POST Index `/issues(?...)`
![Screen Shot 2022-02-27 at 9 11 11 PM](https://user-images.githubusercontent.com/2070909/155913037-841b420a-0468-4c4e-aadb-9cdc75da8d80.png)

GET New `/issues/new`
![Screen Shot 2022-02-27 at 9 11 27 PM](https://user-images.githubusercontent.com/2070909/155913049-be2bc65c-c5fb-43b2-a9a1-729dea1aa58f.png)

GET/PATCH/PUT Edit `/issues/<id>/edit`
![Screen Shot 2022-02-27 at 9 11 46 PM](https://user-images.githubusercontent.com/2070909/155913065-80512a7a-30d3-4047-8789-f2b4ac079fbb.png)

GET Show `/issues/<id>`
![Screen Shot 2022-02-27 at 9 12 02 PM](https://user-images.githubusercontent.com/2070909/155913137-02ded449-6217-453a-91ef-239904846e8a.png)

DELETE `/issues/<id>`

#### Useful commands (along the Makefile)
1. log into container: `make serve` 
2. mysql db: `bundle exec rails db`
3. testing: `bundle exec rails test <relative path dot rb>`
4. testing rspec: `bundle exec rspec <relative path dot rb>`

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
