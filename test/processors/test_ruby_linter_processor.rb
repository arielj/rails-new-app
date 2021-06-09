require "test_helper"

describe "Ruby Linter processor" do
  before do
    @processor = RailsNewApp::RubyLinterProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  ["rubocop", "standardrb"].product(["minitest", "rspec"]).each do |linter, runner|
    it "adds #{linter} for #{runner}" do
      config = {test_runner: {key: runner}, ruby_linter: {key: linter}}
      @processor.update_gemfile(config)
  
      assert @spy.has_been_called_with?("#{linter}-gemfile")

      # standardrb does not have specific config for rspec/minitest
      # we add the rubocop gem in both cases
      assert @spy.has_been_called_with?("rubocop-#{runner}-gemfile")
    end
  end
end
