module RailsNewApp
  class FormBuilderProcessor < Processor
    def update_gemfile(config)
      case config[:form_builder][:key]
      when "simple_form" then apply_template "simple_form-gemfile"
      when "formtastic" then apply_template "formtastic-gemfile"
      end
    end

    def configure(config)
      puts "Processing Form Builder config"
      case config[:form_builder][:key]
      when "simple_form" then apply_template "simple_form-config"
      when "formtastic" then apply_template "formtastic-config"
      end
    end
  end
end
