module RailsNewApp
  class AuthorizationProcessor < Processor
    def update_gemfile(config)
      case config[:authorization][:key]
      when "pundit" then apply_template "pundit-gemfile"
      when "cancancan" then apply_template "cancancan-gemfile"
      end
    end

    def configure(config)
      log "Processing Authorization config"
      case config[:authorization][:key]
      when "pundit" then apply_template "pundit-config"
      when "cancancan" then apply_template "cancancan-config"
      end
    end
  end
end
