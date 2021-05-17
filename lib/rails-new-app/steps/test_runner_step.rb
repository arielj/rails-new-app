module RailsNewApp
  class TestRunnerStep < ChoiceStep
    def options
      ["None", "Minitest (Default)", "RSpec"]
    end

    def lowercase_keys
      ["", "minitest", "rspec"]
    end

    def step_question
      "Type the option number of the test runner gem to use:"
    end

    def after_valid
      "Selected test runner is: #{option}\n"
    end

    def self.default
      {
        option_number: 1,
        name: "Minitest (Default)",
        key: "minitest",
        in_rails_new: true
      }
    end

    def next_step
      option == "None" ? nil : "code_coverage"
    end
  end
end
