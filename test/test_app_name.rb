require "test_helper"

describe "App name" do
  before do
    @runner = RailsNewApp::Runner.new
    user_input("1")
  end

  it "shows the instruction for the user" do
    out, _err = capture_io do
      @runner.show_current_screen
    end

    assert_match %r{Type the name of the app:}, out
    refute_match %r{The selected name is invalid.}, out
  end

  it "shows an error if the name is not valid" do
    user_input("")

    out, _err = capture_io do
      @runner.show_current_screen
    end

    assert_match %r{The selected name is invalid.}, out
    assert_match %r{Type the name of the app:}, out
  end

  it "goes to the menu if the name is valid" do
    user_input("TestApp")

    assert_equal RailsNewApp::MenuScreen, @runner.current_screen.class
    assert_equal "TestApp", @runner.config[:app_name]
  end
end
