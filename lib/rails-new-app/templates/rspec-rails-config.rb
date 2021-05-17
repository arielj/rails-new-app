generate "rspec:install"

# Create the spec folders for RSpec
run "mkdir spec/models"
run "mkdir spec/controllers"
run "mkdir spec/system"
run "mkdir spec/views"
run "mkdir spec/routes"
run "mkdir spec/jobs"
run "mkdir spec/helpers"
run "mkdir spec/mailers"
run "mkdir spec/factories"

# Add `rails spec` task to run tests
inject_into_file "Rakefile", before: "Rails.application.load_tasks\n" do <<-'RUBY'
begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
RUBY
end