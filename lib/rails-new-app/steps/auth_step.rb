module RailsNewApp
  class AuthStep < ChoiceStep
    def options
      ["Authentication", "Authorization"]
    end

    def step_question
      "Type the option to go to a submenu:"
    end

    def return_value
      nil
    end

    def self.default
      {}
    end

    def next_step
      case @selection
      when 1 then :authentication
      when 2 then :authorization
      end
    end
  end
end
