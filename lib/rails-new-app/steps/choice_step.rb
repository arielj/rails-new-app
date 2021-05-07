module RailsNewApp
  class ChoiceStep < Step
    def options
      []
    end

    def option
      options[@selection]
    end

    def ask
      puts step_question
      puts ""

      options.each_with_index do |op, idx|
        puts "#{idx} ) #{op}"
      end
    end
    
    def clean_input(input)
      input.to_i
    end
    
    def valid?(input)
      if options[input]
        true
      else
        puts "Invalid option, choose again:"
        false
      end
    end

    def return_value
      lower = lowercase_keys[@selection]

      {
        option_number: @selection,
        name: option,
        key: lower
      }
    end
  end
end
