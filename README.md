# rails-new-app

Command-line tool to assist in the creation of new Rails 6 apps

## Requirements

- **Ruby (make sure `ruby -v` shows your desired version before running this)**
- **Rails (make sure `rails -v` shows your desired version before running this)**
- **Node.js (version 14.X is recommended)**
- Git (the `rails new` command initializes a git repo)
- Any tool related to the gems you want to use (Redis, PostgreSQL, etc)
- C dev tools if you plan to use any gem that requires compilation of native extensions

> This is currently tested only on Linux and Mac

## Installation:

Run `gem install "rails-new-app"`

## Usage:

Run `rails-new-app` command and follow the step by step wizard.

It will use the current default Rails version, so you should install the version you want to use, these generators are currently tested with Rails 6.

## Current configurations:

- Database: MySQL / PostgreSQL / SQLite
- Tests:
- - runner: none / Minitest / RSpec
- - CodeCoverage: none / Simplecov
- - Factories: none / FactoryBot
- - Fake data: none / Faker
- TemplateEngine: None (just ERB) / Slim / HAML
- FormBuilder: None / Simple Form / Formtastic
- Pagination: None / Pagy / Kaminari / WillPaginate
- JS Framework: None / ReactJS / VueJS / Angular / Elm / Stimulus
- Authorization: None / Pundit / CanCanCan
- Authentication: None / Devise
- RubyLinter: None / RuboCop / StandardRB
- Git: add remote, set branch name, include basic test running github actions config

## TODOs and ideas:

- improve GUI and UX
- - toggle options using arrow keys?
- - describe steps better
- - add links to the different tools
- add tests
- add more tools
- support `rails new` flags configuration
- research requirements
- support a `rails-new-app-defaults` file at the HOME dir to set default options if empty answers
- show an option to NOT ignore or set an RC file, --no-rc is set by default

#### Ideas for other tools:

- dotenv/figaro/dotenv_validator?
- resque/sideqik/suckerpunch/other?
- CSS framework? bootstrap/tailwind/material/spectre/bulma (this affects the form builders processor)
- CI config? ~github actions~ / travis / circleci / bitbucket / gitlab / others
- carrierwave/paperclip/dragonfly/install activestorage?
- js linter? None/ESlint/StandardJS
- exception_notification / airbreak / other reporting tools
- redis?
- memcached/dalli/other?
- add basic docker config?
- pre-commit hooks? overcommit
- admin gems? ActiveAdmin/RailsAdmin/Trestle/others
- type of app: standard/minimal/api
- support other databases like MongoDB that require more config

## For developers

### Setup:

- Clone the repo
- Run `bundle install`
- You can run the app with `./exe/rails-new-app`

### Adding more configurations and tools:

1. Add a new step at `lib/rails-new-app/steps` (or modify an existing one)
2. Collect step config in the `config` hash
3. Update configuration details before confirmation
4. Add a new preocessor at `lib/rails-new-app/processors` (or modify an existing one)
5. Add a template to ONLY modify the gemfile at `lib/rails-new-app/templates`
6. Add another template to ONLY modify the code/configuration at `lib/rails-new-app/templates`
7. Update Runner to run the `update_gemfile` and `configure` methods

- Steps 5 and 6 are split so we can run `bundle install` once.

### Quick scripted execution:

Since the app uses the STDIN to configure the generator, you can pipe a stream of inputs that a user would do to the command to quickly set all the desired options. For example:

```
# inside any text file, like... defaults.txt
1
MyApp
2
3
8
2
0
Y
```

These inputs set the name (1) to `MyApp`, then goes to database config (2) and sets PostrgreSQL (3), then goes to pagination (8) and sets Pagy (2), finally, it goes to `review and confirm` (0) and confirms it (Y).

With that file you can do a quick setup with:

```sh
cat defaults.txt | rails-new-app
```

This can eventually be used to share complete setups or generate defaults.

### Tests:

Run `rake test` or `COVERAGE=true rake test`.

## Changelogs

### 0.0.1

This is a really early Alpha version as a proof of concept.

### 0.0.2

Added navigation between menus.

### 0.0.3

- Added `next_step` to configure related tools without going back to menu
- Apply linter fixes after creation
- Add a git initial commit
- Added new tools: Faker, pagination gems
- Bug fixing

### 0.1

- Refactor screens (ex steps) handling
- Refactor user input handling to allow easier testing
- Added tests for multiple screens
- Bug fixing (Pagy config, incorrect indexing)
- Added SimpleCov and easier dev setup
