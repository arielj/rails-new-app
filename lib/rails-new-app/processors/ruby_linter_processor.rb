module RailsNewApp
  class RubyLinterProcessor < Processor
    def update_gemfile(config)
      case config[:ruby_linter][:key]
      when "rubocop" then apply_template "rubocop-#{config[:test_runner][:key]}-gemfile"
      when "standardrb" then apply_template "standardrb-#{config[:test_runner][:key]}-gemfile"
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
