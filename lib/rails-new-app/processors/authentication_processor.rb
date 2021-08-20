module RailsNewApp
  class AuthenticationProcessor < Processor
    def update_gemfile(config)
      case config[:authentication][:key]
      when "devise" then apply_template "devise-gemfile"
      end
    end

    def configure(config)
      log "Processing Authentication config"
      case config[:authentication][:key]
      when "devise" then apply_template "devise-config"
      end
    end
  end
end
