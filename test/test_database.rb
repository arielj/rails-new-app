require "test_helper"
require_relative "../lib/rails-new-app/screens/database_screen"

describe "Database config" do
  before do
    @runner = RailsNewApp::Runner.new
  end

  it "shows the available databases" do
    out = render
    assert_match %r{2 : Database}, out

    user_input("2")
    assert_equal RailsNewApp::DatabaseScreen, @runner.current_screen.class

    out = render

    assert_match %r{Type the option number of the database to use:}, out
    assert_match %r{1 \) SQLite \(current\)}, out
    assert_match %r{2 \) MySQL / MariaDB}, out
    assert_match %r{3 \) PostgreSQL}, out
    assert_match %r{0 \) Back to menu}, out

    user_input("3")

    assert_equal RailsNewApp::MenuScreen, @runner.current_screen.class
    assert_equal "postgresql", @runner.config[:database][:key]
  end
end
