module RailsNewApp
  class FormBuilderScreen < ChoiceScreen
    def step_question
      "Type the option number of the Form Builder gem to use:"
    end

    def options
      ["None", "Simple Form", "Formtastic"]
    end

    def lowercase_keys
      ["", "simple_form", "formtastic"]
    end

    def after_valid
      puts "Selected Form builder is: #{option}\n"
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
