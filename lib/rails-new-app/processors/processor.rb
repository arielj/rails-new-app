module RailsNewApp
  class Processor
    PATH = File.expand_path("../../templates", __FILE__)

    def self.update_gemfile(config)
      new.update_gemfile(config)
    end

    def self.configure(config)
      new.configure(config)
    end

    def update_gemfile(config)
    end

    def configure(config)
    end

    def apply_template(template)
      system("rails app:template LOCATION=#{PATH}/#{template}.rb")
    end
  end
end
