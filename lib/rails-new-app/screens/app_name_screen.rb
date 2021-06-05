module RailsNewApp
  class AppNameScreen < Screen
    def screen_text
      [].tap do |ls|
        ls << "The selected name is invalid." if @error
        ls << "Type the name of the app:"
      end.join("\n")
    end

    def after_valid
      puts "Your app is: #{@input}\n"
    end

    def valid?(input)
      if /\A[a-z_]+\z/i.match?(input.strip)
        @error = false
        true
      else
        @error = true
        false
      end
    end

    def next_step
      @input != "" ? :menu : :rerender
    end
  end
end
