ENV['env'] ||= 'test'
require 'minitest/autorun'
require_relative "../lib/rails-new-app"

class Minitest::Test
  def select_option(option)
    @runner.process_user_input(option)
  end

  def render
    out, _err = capture_io do
      @runner.show_current_screen
    end

    out
  end
end
