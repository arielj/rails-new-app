module RailsNewApp
  class JavaScriptFrameworkStep < ChoiceStep
    def rails_new_options
      %W[react vue angular elm stimulus]
    end
  
    def options
      ["None (Default)", "ReactJS", "VueJS", "Angular", "Elm", "Stimulus"]
    end
  
    def lowercase_keys
      ["", "react", "vue", "angular", "elm", "stimulus"]
    end
  
    def step_question
      "Type the option number of the JavaScript framework to use:"
    end
  
    def after_valid
      puts "Selected framework is: #{option}\n"
    end
  
    def return_value
      super.tap do |h|
        h[:in_rails_new] = rails_new_options.include?(h[:key])
      end
    end

    def self.default
      {
        option_number: 0,
        name: "None (Default)",
        key: "",
        in_rails_new: false
      }
    end
  end
end
