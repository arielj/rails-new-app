module RailsNewApp
  class RubyLinterStep < ChoiceStep
    def step_question
      "Type the option number of the Ruby Linter gem to use:"
    end

    def options
      ["None (Default)", "RuboCop", "StandardRB"]
    end

    def lowercase_keys
      ["", "rubocop", "standardrb"]
    end

    def after_valid
      puts "Selected Ruby linter is: #{option}\n"
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
