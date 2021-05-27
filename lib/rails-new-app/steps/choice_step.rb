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

      current = config[self.class.key] ? config[self.class.key][:option_number] : nil
      options.each_with_index do |op, idx|
        aux = idx + 1
        is_current = aux == current ? " (current)" : ""
        puts "#{aux} ) #{op}#{is_current}"
      end
      puts ""
      puts "0 ) Back to menu"
    end

    def clean_input(input)
      input.to_i
    end

    def valid?(input)
      if options[input - 1]
        true
      else
        puts "Invalid option, choose again:"
        false
      end
    end

    def return_value
      lower = lowercase_keys[@selection - 1]

      {
        option_number: @selection,
        name: option,
        key: lower
      }
    end
  end
end
