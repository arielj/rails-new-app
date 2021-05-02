module RailsNewApp
  class TestRunnerStep < ChoiceStep
    def options
      ["None", "minitest", "RSpec"]
    end

    def lowercase_keys
      ["", "minitest", "rspec"]
    end

    def step_question
      "Type the option number of the test runner gem to use:"
    end

    def after_valid
      "Selected test runner is: #{option}"
    end
  end
end
