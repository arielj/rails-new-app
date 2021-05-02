# rails-new-app
Command-line tool to assist the creation of new Rails 5 and 6 apps

## Installation:

Run `gem install "rails-new-app"`

## Usage:

Run `rails-new-app` command and follow the step by step wizard

## TODOs and ideas:
- improve GUI and UX
- - toggle options using arrow keys?
- - ability to go back to a previous state
- - describe steps better
- - add links to the different tools
- add tests
- add more tools
- support `rails new` flags configuration
- research requirements
- improve validations (check rails version, ruby version, if gems are compatible with rails, etc)
- make sure the `rails-new-app` command is available globally
- show the user the current Ruby version
- support a `rails-new-app-defaults` file at the HOME dir to set default options if empty answers

#### Ideas for other tools:
- support other databases like MongoDB that require more config
- type of app: standard/minimal/api
- CI config? github actions / travis / circleci / bitbucket / gitlab / others
- js linter? None/ESlint/StandardJS
- factory_bot?
- faker?
- devise?
- carrierwave/paperclip/dragonfly?
- exception_notification / airbreak / other reporting tools
- dotenv/figaro
- redis?
- memcached/dalli/other?
- resque/sideqik/suckerpunch/other?
- CSS framework? bootstrap/tailwind/material/spectre/bulma (this affects the form builders processor)
- add basic docker config?
- admin gems? ActiveAdmin/RailsAdmin/Trestle/others
- pagination? pagy/kaminari/will_paginate
- pre-commit hooks? overcommit

## Adding more configurations and tools:

1 - Add a new step at `lib/rails-new-app/steps` (or modify an existing one)
2 - Collect step config in the `config` hash
3 - Update configuration details before confirmation
4 - Add a new preocessor at `lib/rails-new-app/processors` (or modify an existing one)
5 - Add a template to ONLY modify the gemfile at `lib/rails-new-app/templates`
6 - Add another template to ONLY modify the code/configuration at `lib/rails-new-app/templates`
7 - Update Runner to run the `update_gemfile` and `configure` methods

* Steps 5 and 6 are split so we can run `bundle install` once.

## Changelogs

### 0.0.1
This is a really early Alpha version as a proof of concept.
