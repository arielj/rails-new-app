require "test_helper"

describe "Confirmation" do
  before do
    @runner = RailsNewApp::Runner.new
    @runner.config[:app_name] = "TestApp"
    user_input("0")
  end

  it "shows the options" do
    out = render
    assert_match %r{Type 'Y\(es\)' to confirm, 'B\(ack\) to go back, or 'N\(o\)' to abort}, out
  end

  it "can be aborted" do
    assert_equal :abort, user_input("No")
  end

  %w[y Y yes YES Yes yEs YeS yeS].each do |yes|
    it "can be accepted" do
      assert_equal :finish, user_input(yes)
    end
  end

  it "can go back to menu" do
    assert_equal RailsNewApp::MenuScreen, user_input("Back").class
  end
end
