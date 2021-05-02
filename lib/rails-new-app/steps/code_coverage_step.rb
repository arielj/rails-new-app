module RailsNewApp
  class CodeCoverageStep < ChoiceStep
    def step_question
      "Type the option number of the code coverage tool to use:"
    end

    def options
      ["None", "SimpleCov"]
    end

    def lowercase_keys
      ["", "simplecov"]
    end

    def after_valid
      puts "Selected code coverage tool is: #{option}"
    end
  end
end
