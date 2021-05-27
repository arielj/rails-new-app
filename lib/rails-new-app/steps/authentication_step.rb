module RailsNewApp
  class AuthenticationStep < ChoiceStep
    def step_question
      "Type the option number of the Authentication gem to use:"
    end

    def options
      ["None", "Devise"]
    end

    def lowercase_keys
      ["", "devise"]
    end

    def after_valid
      puts "Selected authentication gem is: #{option}\n"
    end

    def self.default
      {
        option_number: 1,
        name: "None",
        key: ""
      }
    end
  end
end
