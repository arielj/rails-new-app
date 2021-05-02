module RailsNewApp
  class TestRunnerProcessor < Processor
    def update_gemfile(config)
      case config[:test_runner][:key]
      when "rspec" then apply_template "rspec-rails-gemfile"
      end
    end

    def configure(config)
      puts "Processing test runner config"
      case config[:test_runner][:key]
      when "rspec" then apply_template "rspec-rails-config"
      end
    end
  end
end
