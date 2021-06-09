require "test_helper"

describe "Authorization processor" do
  before do
    @processor = RailsNewApp::AuthorizationProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  ["pundit", "cancancan"].each do |gem|
    it "adds #{gem}" do
      config = {authorization: {key: gem}}
      @processor.update_gemfile(config)
  
      assert @spy.has_been_called_with?("#{gem}-gemfile")
    end
  end
end
