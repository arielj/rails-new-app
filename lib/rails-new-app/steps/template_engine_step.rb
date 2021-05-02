module RailsNewApp
  class TemplateEngineStep < ChoiceStep
    def step_question
      "Type the option number of the Template Engine gem to use:"
    end

    def options
      ["None", "Slim", "HAML"]
    end

    def lowercase_keys
      ["", "slim", "haml"]
    end

    def after_valid
      puts "Selected template engine is: #{option}"
    end
  end
end
