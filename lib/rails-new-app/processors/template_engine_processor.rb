module RailsNewApp
  class TemplateEngineProcessor < Processor
    def update_gemfile(config)
      case config[:template_engine][:key]
      when "slim" then apply_template "slim-gemfile"
      when "haml" then apply_template "haml-gemfile"
      end
    end
  end
end
