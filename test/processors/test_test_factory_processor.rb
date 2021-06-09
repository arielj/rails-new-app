require "test_helper"

describe "Test Factory processor" do
  before do
    @processor = RailsNewApp::TestFactoryProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  it "adds factory_bot if there's a test runner" do
    config = {test_factory: {key: "factory_bot"}, test_runner: {key: ["minitest", "rspec"].sample}}
    @processor.update_gemfile(config)

    assert @spy.has_been_called_with?("factory_bot-gemfile")
  end

  it "doest not add factory_bot if there's no test runner" do
    config = {test_factory: {key: "factory_bot"}, test_runner: {key: ""}}
    @processor.update_gemfile(config)

    refute @spy.has_been_called_with?("factory_bot-gemfile")
  end
end
