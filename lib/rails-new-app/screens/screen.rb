module RailsNewApp
  class Screen
    attr_reader :config

    def initialize(config)
      @config = config
      @input = ""
    end

    def self.clean_name
      to_s.gsub("Screen", "").gsub("RailsNewApp::", "")
    end

    def self.key
      clean_name.underscore.to_sym
    end

    def screen_text
      raise "screen text must be re-defined"
    end

    def process_user_input(input)
      if validate_user_input(input)
        [next_step, return_value]
      else
        [:rerender, nil]
      end
    end

    def validate_user_input(input)
      input = clean_input(input)
      if valid?(input)
        @input = input
        true
      end
    end

    # clean the input if needed before validations
    def clean_input(input)
      input.strip
    end

    # validate the input
    def valid?(input)
      @error = false
      true
    end

    # after valid message
    def after_valid
    end

    # process @input to return a different value
    def return_value
      @input
    end

    def self.default
      ""
    end

    def next_step
      :menu
    end
  end
end
