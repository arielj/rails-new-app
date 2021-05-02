module RailsNewApp
  class CodeCoverageProcessor < Processor
    def udpate_gemfile(config)
      case config[:code_coverage][:key]
      when "simplecov" then apply_template "simplecov-gemfile"
      end
    end

    def configure(config)
      puts "Processing Code Coverage config"
      case config[:code_coverage][:key]
      when "simplecov" then apply_template "simplecov-#{config[:test_runner][:key]}-config"
      end
    end
  end
end
