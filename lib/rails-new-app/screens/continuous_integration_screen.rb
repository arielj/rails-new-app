module RailsNewApp
  class ContinuousIntegrationScreen < ChoiceScreen
    def step_question
      "Type the option number of the CI tool to use, this will add a basic configuration:"
    end

    def options
      ["None", "Github Actions"]
    end

    def lowercase_keys
      ["", "github_actions"]
    end

    def after_valid
      puts "Selected CI tool is: #{option}\n"
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
