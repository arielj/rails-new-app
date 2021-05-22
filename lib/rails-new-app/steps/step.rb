module RailsNewApp
  class Step
    def self.clean_name
      to_s.gsub("Step", "").gsub("RailsNewApp::", "")
    end

    def self.key
      clean_name.underscore.to_sym
    end

    def self.run(config)
      new.run(config)
    end

    attr_reader :config

    def run(current_config)
      @config = current_config

      system("clear") if config[:navigation]

      ask
      read_and_validate
      after_valid
      return_value
    end

    def step_title
      "Generic step question"
    end

    # describe the current step
    def ask
      puts step_question
    end

    # loop until the input is valid, sets @selection
    def read_and_validate
      loop do
        input = clean_input(gets.chomp)
        if valid?(input)
          @selection = input
          return true
        end
      end
    end

    # clean the input if needed before validations
    def clean_input(input)
      input.strip
    end

    # validate the input
    def valid?(input)
      true
    end

    # after valid message
    def after_valid
    end

    # process @selection to return a different value
    def return_value
      @selection
    end

    def self.default
      ""
    end

    def next_step
      nil
    end
  end
end
