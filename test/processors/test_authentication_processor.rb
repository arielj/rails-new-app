require "test_helper"

describe "Authentication processor" do
  before do
    @processor = RailsNewApp::AuthenticationProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  it "adds devise" do
    config = {authentication: {key: "devise"}}
    @processor.update_gemfile(config)

    assert @spy.has_been_called_with?("devise-gemfile")
  end
end
