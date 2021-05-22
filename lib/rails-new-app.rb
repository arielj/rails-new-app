require_relative "rails-new-app/string_underscore"
require_relative "rails-new-app/version"
require_relative "rails-new-app/runner"

module RailsNewApp
  def self.run
    navigation = true
    ARGV.each do |arg|
      case arg
      when "navigation=false" then navigation = false
      when "-v", "--version"
        puts "rails-new-app #{RailsNewApp::VERSION}"
        exit(0)
      end
    end
    ARGV.clear

    Runner.new.run(navigation)
  end
end
