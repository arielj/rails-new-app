require "test_helper"

describe "CodeCoverage processor" do
  before do
    @processor = RailsNewApp::CodeCoverageProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  it "adds SimpleCov if there's a test runner" do
    config = {code_coverage: {key: "simplecov"}, test_runner: {key: ["minitest", "rspec"].sample}}
    @processor.update_gemfile(config)
  
    assert @spy.has_been_called_with?("simplecov-gemfile")
  end

  it "does not add SimpleCov if there no test runner" do
    config = {code_coverage: {key: "simplecov"}, test_runner: {key: ""}}
    @processor.update_gemfile(config)
  
    refute @spy.has_been_called_with?("simplecov-gemfile")
  end
end
