require_relative "rails-new-app/runner"

module RailsNewApp
  def self.run
    Runner.new.run
  end
end
