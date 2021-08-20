require "test_helper"

describe "Running processors" do
  before do
    @runner = RailsNewApp::Runner.new
  end

  it "updates the gemfile" do
    spies =
      [
        RailsNewApp::TestRunnerProcessor,
        RailsNewApp::CodeCoverageProcessor,
        RailsNewApp::TestFactoryProcessor,
        RailsNewApp::TestFakeDataProcessor,
        RailsNewApp::TemplateEngineProcessor,
        RailsNewApp::FormBuilderProcessor,
        RailsNewApp::RubyLinterProcessor,
        RailsNewApp::PaginationProcessor,
        RailsNewApp::AuthorizationProcessor,
        RailsNewApp::AuthenticationProcessor
      ].map do |p|
        Spy.on(p, :update_gemfile)
      end
    
    @runner.update_gemfile

    spies.all?(&:has_been_called?)
  end

  it "applies configurations" do
    spies =
      [
        RailsNewApp::TestRunnerProcessor,
        RailsNewApp::CodeCoverageProcessor,
        RailsNewApp::TestFactoryProcessor,
        RailsNewApp::FormBuilderProcessor,
        RailsNewApp::RubyLinterProcessor,
        RailsNewApp::PaginationProcessor,
        RailsNewApp::AuthorizationProcessor,
        RailsNewApp::AuthenticationProcessor
      ].map do |p|
        Spy.on(p, :configure)
      end
    
    @runner.apply_configuration

    spies.all?(&:has_been_called?)
  end
end
