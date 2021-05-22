# rails-new-app
Command-line tool to assist in the creation of new Rails 5 and 6 apps

## Installation:

Run `gem install "rails-new-app"`

## Usage:

Run `rails-new-app` command and follow the step by step wizard.

### Alternative

If, for any reason, the menu navigation does not work, run `rails-new-app navigation=false`.

## Current configurations:
- Rails version (validate and install)
- Database: none / MySQL / PostgreSQL / SQLite
- Tests:
- - runner: none / Minitest / RSpec
- - CodeCoverage: none / Simplecov
- - Factories: none / FactoryBot
- TemplateEngine: None (just ERB) / Slim / HAML
- RubyLinter: None / RuboCop / StandardRB
- FormBuilder: None / Simple Form / Formtastic
- JS Framework: None / ReactJS / VueJS / Angular / Elm / Stimulus

## TODOs and ideas:
- improve GUI and UX
- - toggle options using arrow keys?
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
- pre-commit hooks? overcommit
- cancancan/pundit ?

## Adding more configurations and tools:

1. Add a new step at `lib/rails-new-app/steps` (or modify an existing one)
2. Collect step config in the `config` hash
3. Update configuration details before confirmation
4. Add a new preocessor at `lib/rails-new-app/processors` (or modify an existing one)
5. Add a template to ONLY modify the gemfile at `lib/rails-new-app/templates`
6. Add another template to ONLY modify the code/configuration at `lib/rails-new-app/templates`
7. Update Runner to run the `update_gemfile` and `configure` methods

* Steps 5 and 6 are split so we can run `bundle install` once.

## Changelogs

### 0.0.1
This is a really early Alpha version as a proof of concept.

### 0.0.2
Added navigation between menus.
