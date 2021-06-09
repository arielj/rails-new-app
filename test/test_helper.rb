ENV["env"] ||= "test"

if ENV["COVERAGE"]
  require "simplecov"
  require "simplecov-console"
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ])
  SimpleCov.start
end

require "minitest/autorun"
require_relative "../lib/rails-new-app"

require 'spy/integration'

class Minitest::Test
  def user_input(option)
    @runner.process_user_input(option)
  end

  def render
    out, _err = capture_io do
      @runner.show_current_screen
    end

    out
  end
end
