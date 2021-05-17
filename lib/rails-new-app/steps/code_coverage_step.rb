module RailsNewApp
  class CodeCoverageStep < ChoiceStep
    def step_question
      warning =
        if config[:test_runner][:key] == ""
          "This configuration will be ignored because you selected no test runner\n"
        else
          ""
        end
      "#{warning}Type the option number of the code coverage tool to use:"
    end

    def options
      ["None", "SimpleCov"]
    end

    def lowercase_keys
      ["", "simplecov"]
    end

    def after_valid
      puts "Selected code coverage tool is: #{option}\n"
    end

    def self.default
      {
        option_number: 0,
        name: "None (Default)",
        key: "",
      }
    end
  end
end
