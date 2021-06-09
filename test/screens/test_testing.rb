require "test_helper"

describe "Testing config" do
  before do
    @runner = RailsNewApp::Runner.new
  end

  it "shows the available test runners" do
    out = render
    assert_match %r{3 : TestRunner}, out

    user_input("3")
    assert_equal RailsNewApp::TestRunnerScreen, @runner.current_screen.class

    out = render

    assert_match %r{Type the option number of the test runner gem to use:}, out
    assert_match %r{1 \) None}, out
    assert_match %r{2 \) Minitest \(current\)}, out
    assert_match %r{3 \) RSpec}, out
    assert_match %r{0 \) Back to menu}, out

    user_input("3")

    assert_equal RailsNewApp::CodeCoverageScreen, @runner.current_screen.class
    assert_equal "rspec", @runner.config[:test_runner][:key]
  end

  it "shows code coverage options if test runner" do
    user_input("3") # test runner option
    user_input("3") # rspec

    assert_equal RailsNewApp::CodeCoverageScreen, @runner.current_screen.class

    out = render
    assert_match %r{Type the option number of the code coverage tool to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) SimpleCov}, out
    assert_match %r{0 \) Back to menu}, out
  end

  it "shows the menu if no test runner" do
    user_input("3") # test runner option
    user_input("1") # none

    assert_equal RailsNewApp::MenuScreen, @runner.current_screen.class
  end

  it "shows the factory options after code coverage" do
    user_input("3") # test runner option
    user_input("2") # minitest
    user_input("2") # simplecov

    assert_equal RailsNewApp::TestFactoryScreen, @runner.current_screen.class

    out = render
    assert_match %r{Type the option number of the test factories tool to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) FactoryBot}, out
    assert_match %r{0 \) Back to menu}, out
  end

  it "shows the fake data options after code coverage and factory" do
    user_input("3") # test runner option
    user_input("3") # rspec
    user_input("1") # no code coverage
    user_input("2") # factory_bot

    assert_equal RailsNewApp::TestFakeDataScreen, @runner.current_screen.class

    out = render
    assert_match %r{Type the option number of the test fake data tool to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) Faker}, out
    assert_match %r{0 \) Back to menu}, out
  end
end
