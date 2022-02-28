#### Unity Sample Issue Tracking Service

## Overview
Unity desperately needs yet another issue tracking service (YAITS!) and has chosen you to design and
build the backend for it. Other developers should be able to use HTTP requests to invoke APIs that...

 - [ ] get a list of issues
 - [ ] search issues via attribute criteria matching (e.g. find issues of priority 7 or higher)
 - [ ] create a new issue
 - [ ] update an issue
 - [ ] delete an issue

Issues should...
 - [x] be unique
 - [x] have a short description
 - [x] have a detailed description
 - [x] have a priority
 - [x] have a status (e.g. open, closed)
 - [x] be assignable to a team member

...and include anything else you deem necessary.

Too easy? Feel free to also consider...
 -  [ ] simple frontend forms/pages to expose the APIs for end users
 -  [ ] tests
 -  [ ] deployment scripts/tools
 -  [ ] authentication
 -  [ ] a system for inviting members into a team
 -  [ ] conditional access to a subset of issues by non-team members
 -  [ ] allowing members to comment on issues
 -  [ ] voting for issues

...or anything else that strikes your fancy.

When you're ready...
 - [ ] include a short description of your design, discussing any trade-offs/compromises, scale, or
performance issues, along with what the future might hold for extending your service,
 - [ ] create a new git repository (or a similar shareable version control) at the start of your project,
make sensible check-ins throughout your project
 - [ ] zip up your repo (including the version control directory) and publish away.

### How to run 
1. from within project's folder, type `make up`
2. from browser window, head http://0.0.0.0:8888/issues
3. when done, do not forget to detach the containers with `make down` 

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

