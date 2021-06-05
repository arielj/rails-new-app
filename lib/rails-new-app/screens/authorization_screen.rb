module RailsNewApp
  class AuthorizationScreen < ChoiceScreen
    def step_question
      "Type the option number of the Authorization gem to use:"
    end

    def options
      ["None", "Pundit", "Can Can Can"]
    end

    def lowercase_keys
      ["", "pundit", "cancancan"]
    end

    def after_valid
      puts "Selected authorization gem is: #{option}\n"
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
