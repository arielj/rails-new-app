require "test_helper"
require_relative "../lib/rails-new-app/screens/ruby_linter_screen"

describe "Ruby Linter config" do
  before do
    @runner = RailsNewApp::Runner.new
  end

  it "shows the available linters" do
    out = render
    assert_match %r{5 : RubyLinter}, out

    user_input("5")
    assert_equal RailsNewApp::RubyLinterScreen, @runner.current_screen.class

    out = render

    assert_match %r{Type the option number of the Ruby Linter gem to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) RuboCop}, out
    assert_match %r{3 \) StandardRB}, out

    user_input("2")

    assert_equal RailsNewApp::MenuScreen, @runner.current_screen.class
    assert_equal "rubocop", @runner.config[:ruby_linter][:key]
  end
end
