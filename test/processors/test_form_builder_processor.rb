require "test_helper"

describe "Form Builder processor" do
  before do
    @processor = RailsNewApp::FormBuilderProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  ["formtastic", "simple_form"].each do |gem|
    it "adds #{gem}" do
      config = {form_builder: {key: gem}}
      @processor.update_gemfile(config)
  
      assert @spy.has_been_called_with?("#{gem}-gemfile")
    end
  end
end
