require "test_helper"
%w[test_runner test_factory test_fake_data].each do |file|
  require_relative "../lib/rails-new-app/screens/#{file}_screen"
end

describe "Testing config" do
  before do
    @runner = RailsNewApp::Runner.new
  end

  it "shows the available test runners" do
    out = render
    assert_match %r{3 : TestRunner}, out

    select_option("3")
    assert_equal RailsNewApp::TestRunnerScreen, @runner.current_screen.class

    out = render

    assert_match %r{Type the option number of the test runner gem to use:}, out
    assert_match %r{1 \) None}, out
    assert_match %r{2 \) Minitest \(current\)}, out
    assert_match %r{3 \) RSpec}, out
    assert_match %r{0 \) Back to menu}, out

    select_option("3")

    assert_equal RailsNewApp::CodeCoverageScreen, @runner.current_screen.class
    assert_equal "rspec", @runner.config[:test_runner][:key]
  end

  it "shows code coverage options if test runner" do
    select_option("3") # test runner option
    select_option("3") # rspec

    assert_equal RailsNewApp::CodeCoverageScreen, @runner.current_screen.class

    out = render
    assert_match %r{Type the option number of the code coverage tool to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) SimpleCov}, out
    assert_match %r{0 \) Back to menu}, out
  end

  it "shows the menu if no test runner" do
    select_option("3") # test runner option
    select_option("1") # none

    assert_equal RailsNewApp::MenuScreen, @runner.current_screen.class
  end

  it "shows the factory options after code coverage" do
    select_option("3") # test runner option
    select_option("2") # minitest
    select_option("2") # simplecov

    assert_equal RailsNewApp::TestFactoryScreen, @runner.current_screen.class

    out = render
    assert_match %r{Type the option number of the test factories tool to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) FactoryBot}, out
    assert_match %r{0 \) Back to menu}, out
  end

  it "shows the fake data options after code coverage and factory" do
    select_option("3") # test runner option
    select_option("3") # rspec
    select_option("1") # no code coverage
    select_option("2") # factory_bot

    assert_equal RailsNewApp::TestFakeDataScreen, @runner.current_screen.class

    out = render
    assert_match %r{Type the option number of the test fake data tool to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) Faker}, out
    assert_match %r{0 \) Back to menu}, out
  end
end
