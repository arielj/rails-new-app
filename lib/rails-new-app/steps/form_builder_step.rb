module RailsNewApp
  class FormBuilderStep < ChoiceStep
    def step_question
      "Type the option number of the Form Builder gem to use:"
    end

    def options
      ["None (Default)", "Simple Form", "Formtastic"]
    end

    def lowercase_keys
      ["", "simple_form", "formtastic"]
    end

    def after_valid
      puts "Selected Form builder is: #{option}\n"
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
