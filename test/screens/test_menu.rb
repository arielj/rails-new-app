require "test_helper"

describe "Menu" do
  before do
    @runner = RailsNewApp::Runner.new
  end

  it "shows the first menu page" do
    out, _err = capture_io do
      @runner.show_current_screen
    end

    assert_match %r{1 : AppName}, out
    assert_match %r{2 : Database}, out
    assert_match %r{3 : TestRunner}, out
    assert_match %r{4 : JavaScriptFramework}, out
    assert_match %r{5 : RubyLinter}, out
    assert_match %r{6 : TemplateEngine}, out
    assert_match %r{7 : FormBuilder}, out
    assert_match %r{8 : Pagination}, out
    assert_match %r{9 : Auth}, out

    assert_match %r{n : Next menu}, out
    assert_match %r{0 : Review and confirm}, out

    assert_match %r{Type the number of the menu and press enter:}, out
  end

  it "shows the second menu page" do
    @runner.menu.go_to_next_page
    out, _err = capture_io do
      @runner.show_current_screen
    end

    assert_match %r{1 : GitRemote}, out
    assert_match %r{2 : GitBranch}, out
    assert_match %r{3 : ContinuousIntegration}, out

    assert_match %r{p : Previous menu}, out
    assert_match %r{0 : Review and confirm}, out

    assert_match %r{Type the number of the menu and press enter:}, out
  end
end
