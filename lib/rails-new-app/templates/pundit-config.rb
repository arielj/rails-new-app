inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
  <<~'RUBY'
    include Pundit
  RUBY
end

generate("pundit:install")
