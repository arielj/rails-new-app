module RailsNewApp
  class Step
    def self.run
      new.run
    end

    def run
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
  end
end