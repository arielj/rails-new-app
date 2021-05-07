module RailsNewApp
  class CodeCoverageProcessor < Processor
    def udpate_gemfile(config)
      return if config[:test_runner][:key] == ""

      case config[:code_coverage][:key]
      when "simplecov" then apply_template "simplecov-gemfile"
      end
    end

    def configure(config)
      return if config[:test_runner][:key] == ""

      puts "Processing Code Coverage config"
      case config[:code_coverage][:key]
      when "simplecov" then apply_template "simplecov-#{config[:test_runner][:key]}-config"
      end
    end
  end
end
