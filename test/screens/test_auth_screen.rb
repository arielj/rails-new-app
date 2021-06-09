require "test_helper"

describe "Auth config" do
  before do
    @runner = RailsNewApp::Runner.new
    user_input("n")
  end

  it "shows the auth categories" do
    out = render
    assert_match %r{1 : Auth}, out

    user_input("1")
    assert_equal RailsNewApp::AuthScreen, @runner.current_screen.class

    out = render

    assert_match %r{Type the option to go to a submenu:}, out
    assert_match %r{1 \) Authentication}, out
    assert_match %r{2 \) Authorization}, out
    assert_match %r{0 \) Back to menu}, out
  end

  it "can set an authentication gem" do
    user_input("1") # auth
    user_input("1") # authentication

    out = render

    assert_match %r{Type the option number of the Authentication gem to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) Devise}, out
    assert_match %r{0 \) Back to menu}, out
  end

  it "can set an authorization gem" do
    user_input("1") # auth
    user_input("2") # authorization

    out = render

    assert_match %r{Type the option number of the Authorization gem to use:}, out
    assert_match %r{1 \) None \(current\)}, out
    assert_match %r{2 \) Pundit}, out
    assert_match %r{3 \) Can Can Can}, out
    assert_match %r{0 \) Back to menu}, out
  end
end
