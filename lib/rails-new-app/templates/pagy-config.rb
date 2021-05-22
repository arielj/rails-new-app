initializer "pagy.rb", "Check initializer options at: https://github.com/ddnexus/pagy/blob/master/lib/config/pagy.rb"

inject_into_file "app/helpers/application_helper.rb", after: "module ApplicationHelper\n" do
  <<~'RUBY'
    include Pagy::Frontend
  RUBY
end

inject_into_file "app/controllers/application_controller.rb", after: "class ApplicationController < ActionController::Base\n" do
  <<~'RUBY'
    include Pagy::Backend
  RUBY
end
