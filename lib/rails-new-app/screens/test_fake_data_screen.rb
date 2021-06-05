module RailsNewApp
  class TestFakeDataScreen < ChoiceScreen
    def step_question
      warning =
        if config[:test_runner][:key] == ""
          "This configuration will be ignored because you selected no test runner\n"
        else
          ""
        end
      "#{warning}Type the option number of the test fake data tool to use:"
    end

    def options
      # TODO: add ffaker and Fake Person?
      ["None", "Faker"]
    end

    def lowercase_keys
      ["", "faker"]
    end

    def after_valid
      puts "Selected test fake data tool is: #{option}\n"
    end

    def self.default
      {
        option_number: 0,
        name: "None (Default)",
        key: ""
      }
    end
  end
end
