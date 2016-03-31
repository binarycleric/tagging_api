# Tagging API 

https://gist.github.com/dradford/9407c8c6af5ea3469596

A general use tagging api for distributed systems. Tag anything with a type and
UUID.

## Dependencies

* Ruby 2.3.0
* Bundler
* SQLite
* (Optional) A ruby version manager like chruby or rbenv

## Install

```bash
$ git clone https://github.com/binarycleric/tagging_api.git
$ cd ./tagging_api
$ bundle install
$ bundle exec rake db:create db:migrate
$ bundle exec rails server
```

## Testing

```bash
$ bundle exec rake db:drop db:create db:migrate RAILS_ENV=test
$ bundle exec rake
```

### Acceptance Testing

A rough acceptance test suite has been created. It requires an instance of the
service running and makes various HTTP connections to ensure basic functionality
is working. Eventually I'd like to move this over to a proper tool but this
should help us get off the ground.

```bash
$ bundle exec rails s
# In a different tab/pane
$ bundle exec rake acceptance
```

## Changes

### Used 'PUT /tags' instead of 'POST /tags'

After some thought I decided that a `PUT` action made the most sense for
creating new tags. The reasoning for this is because I am assuming that by using
this service, you already have the entity created upstream. Since we are
essentially creating new fields on an existing record (in the platform-wide
sense) we're actually modifying existing records.

## Questions

### Why use specific routes instead of `resources`?

Since we have nested params (`entity_id` and `entity_type`), trying to hack that
functionality into Rails routes would most likely result in unexpected bugs and
somewhat confusing code. To make our routes as clear as possible I felt that
adding each one manually was the best approach.

### Stats looks a little sparse

Correct. I had thought about various features to add to the stats endpoints, but
I'm not 100% sure of their uses-cases yet. Instead of possibly building features
we may not need, I'd much rather add some basics to get started then iterate as
we discover more use-cases.

