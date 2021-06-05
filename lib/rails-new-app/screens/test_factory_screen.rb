module RailsNewApp
  class TestFactoryScreen < ChoiceScreen
    def step_question
      warning =
        if config[:test_runner][:key] == ""
          "This configuration will be ignored because you selected no test runner\n"
        else
          ""
        end
      "#{warning}Type the option number of the test factories tool to use:"
    end

    def options
      # TODO: add Forgery and Fabrication?
      ["None", "FactoryBot"]
    end

    def lowercase_keys
      ["", "factory_bot"]
    end

    def after_valid
      puts "Selected test factories tool is: #{option}\n"
    end

    def self.default
      {
        option_number: 0,
        name: "None (Default)",
        key: ""
      }
    end

    def next_step
      :test_fake_data
    end
  end
end
