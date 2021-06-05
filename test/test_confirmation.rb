require "test_helper"

describe "Confirmation" do
  before do
    @runner = RailsNewApp::Runner.new
    @runner.config[:app_name] = "TestApp"
    select_option("0")
  end

  it "shows the options" do
    out = render
    assert_match %r{Type 'Y\(es\)' to confirm, 'B\(ack\) to go back, or 'N\(o\)' to abort}, out
  end

  it "can be aborted" do
    assert_equal :abort, select_option("No")
  end

  it "can be accepted" do
    assert_equal :finish, select_option("Yes")
  end

  it "can go back to menu" do
    assert_equal RailsNewApp::MenuScreen, select_option("Back").class
  end
end
