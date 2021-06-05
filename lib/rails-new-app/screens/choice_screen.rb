module RailsNewApp
  class ChoiceScreen < Screen
    def options
      []
    end

    def option
      options[@input - 1]
    end

    def screen_text
      [].tap do |ls|
        ls << @error if @error
        ls << step_question
        ls << ""

        current = config[self.class.key] ? config[self.class.key][:option_number] : nil
        options.each_with_index do |op, idx|
          aux = idx + 1
          is_current = aux == current ? " (current)" : ""
          ls << "#{aux} ) #{op}#{is_current}"
        end
        ls << ""
        ls << "0 ) Back to menu"
      end.join("\n")
    end

    def clean_input(input)
      input.to_i
    end

    def valid?(input)
      if options[input - 1]
        @error = false
        true
      else
        @error = "Invalid option, choose again:"
        false
      end
    end

    def return_value
      lower = lowercase_keys[@input - 1]

      {
        option_number: @input,
        name: option,
        key: lower
      }
    end
  end
end
