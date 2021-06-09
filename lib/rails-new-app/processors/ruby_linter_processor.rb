module RailsNewApp
  class RubyLinterProcessor < Processor
    def update_gemfile(config)
      case config[:ruby_linter][:key]
      when "rubocop", "standardrb"
        apply_template "#{config[:ruby_linter][:key]}-gemfile"

        # standardrb does not have specific config for rspec/minitest
        # we add the rubocop gem in both cases
        case config[:test_runner][:key]
        when "minitest" then apply_template "rubocop-minitest-gemfile"
        when "rspec" then apply_template "rubocop-rspec-gemfile"
        end
      end
    end

    def configure(config)
      puts "Processing Ruby Linter config"
      case config[:ruby_linter][:key]
      when "rubocop" then apply_template "rubocop-config"
      when "standardrb" then apply_template "standardrb-config"
      end
    end
  end
end
