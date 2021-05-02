module RailsNewApp
  class RailsVersionStep < Step
    def valid?(ver)
      if ver =~ /\A[56].\d.\d\z/
        # puts "Validating against Rubygems..."
        # uncomment this to validate the input against RubyGems
        # `gem list -r -e -a rails | grep '#{ver}'` != false
        true
      else
        puts "Invalid Rails version, type the version you want to use:"
        false
      end
    end
    
    def step_question
      # TODO: inform the user that the version will be the latest path version
      "Type the version of Rails you want to use:"
    end

    def after_valid
      puts "Selected version is: #{@selection}"
    end
  end
end
