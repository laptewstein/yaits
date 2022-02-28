#### Unity Sample Issue Tracking Service

### How to run assuming you have installed docker and cloned this repository
1. From within project's folder, type `make up`
2. Head to http://0.0.0.0:8888/issues
3. Do not forget to detach containers with `make down` 

## Overview
Unity desperately needs yet another issue tracking service (YAITS!) and has chosen you to design and
build the backend for it. Other developers should be able to use HTTP requests to invoke APIs that...

 - [x] get a list of issues
 - [x] search issues via attribute criteria matching (e.g. find issues of priority 7 or higher)
 - [x] create a new issue
 - [x] update an issue
 - [x] delete an issue

Issues should...
 - [x] be unique
 - [x] have a short description
 - [x] have a detailed description
 - [x] have a priority
 - [x] have a status (e.g. open, closed)
 - [x] be assignable to a *[team member](https://github.com/Kartoshka548/yaits/issues/5)

...and include anything else you deem necessary.

Too easy? Feel free to also consider...
 -  [x] simple frontend forms/pages to expose the APIs for end users
 -  [x] tests
 -  [x] deployment scripts/tools
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