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
      <<-QUESTION
Type the version of Rails you want to use:
! Notice that Rails will use the latest patch version for a given version !

QUESTION
    end

    def after_valid
      puts "Selected version is: #{@selection}\n"
    end

    def self.default
      ""
    end
  end
end
