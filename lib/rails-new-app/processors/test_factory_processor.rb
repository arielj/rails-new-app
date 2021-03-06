module RailsNewApp
  class TestFactoryProcessor < Processor
    def update_gemfile(config)
      return if config[:test_runner][:key] == ""

      case config[:test_factory][:key]
      when "factory_bot" then apply_template "factory_bot-gemfile"
      end
    end

    def configure(config)
      return if config[:test_runner][:key] == ""

      log "Processing Test Factory config"
      case config[:test_factory][:key]
      when "factory_boy" then apply_template "factory_bot-#{config[:test_runner][:key]}-config"
      end
    end
  end
end
