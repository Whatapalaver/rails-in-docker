# Rails in Docker with Webpacker

This is an installation of Rails 5.2 running in a Ruby 2.4.9 Docker container.
Webpacker has been added so I can experiment with javascript handling using webpack rather than asset pipeline.

## Museum Object

Basic implementation with an Event and Article Model all within an Admin namespace.
Fixes the mimemagic debacle
Adds utility to import museum objects from an external API. Ultimately will include service object to update these imported objects as the external reference is modified.

And an increasing number of mini-app test branches:

1. namespaced-event-article - 
2. polymorphic-namespaced - polymorphic item-references with implementation in Articles only. Uses accepts_nested_attributes_for to handle creation of new item references within an article.
3. polymorphic-validations - Handles the creation of item_references in a more manual fashion in order to ensure uniqueness validation.
4. museum-object - Import objects from external museum API. Plan to handle updates to these objects as API shows modifications

This is a barebones installation of Rails 5.2 running in a Ruby 2.4 Docker container. This branch includes rspec, cucumber, factory-bot and database-cleaner for BDD testing. The setup follows the following [instruction from Semaphore](https://semaphoreci.com/community/tutorials/setting-up-a-bdd-stack-on-a-rails-5-application).

There are two branches:

1. Master - A simple rails 5.2 install
2. webpacker - This has webpacker installed from the Gemfile so that I can see the changes in how javascript is handled
3. cucumber-bdd - The rails 5.2 install with the addition of rspec, cucumber, factory-bot and database-cleaner for BDD testing. The setup follows the following [instruction from Semaphore](https://semaphoreci.com/community/tutorials/setting-up-a-bdd-stack-on-a-rails-5-application).

## Initial Setup

- `docker-compose build`
- `docker-compose up`
- In a separate terminal `docker-compose run web rake db:create`
- If there are any migrations run `docker-compose run web rake db:create`
- And if you have any seed data run `docker-compose run web rake db:seed`

## Working with Docker

### Gems

The bundle install action has been extracted away from the Dockerfile as this greatly enhances efficiency of the build process. The gemfile is now checked at `docker-compose up` stage. Therefore whenever you make a change to the gems you should take the containers down with `docker-compose down` and bring them back up with `docker-compose up`.

### Running Tests

- Run all tests with: `docker-compose run web bundle exec rake`
