module RailsNewApp
  class AppNameStep < Step
    def step_question
      "Type the name of the app:"
    end

    def after_valid
      puts "Your app is: #{@selection}\n"
    end

    def valid?(input)
      if input.strip =~ /\A[a-z_]+\z/i
        true
      else
        puts "Invalid app name"
        false
      end
    end
  end
end
