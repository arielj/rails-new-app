module RailsNewApp
  class Processor
    TEMPLATES_PATH = File.expand_path("../../templates", __FILE__)

    def self.update_gemfile(config)
      new.update_gemfile(config)
    end

    def self.configure(config)
      new.configure(config)
    end

    def update_gemfile(config)
      raise "Processor must redefine this method"
    end

    def configure(config)
      raise "Processor must redefine this method"
    end

    def apply_template(template)
      run_cmnd("rails app:template LOCATION=#{TEMPLATES_PATH}/#{template}.rb")
    end

    def log(string)
      puts(string) unless ENV["env"] == "test"
    end

    def run_cmnd(cmd)
      system(cmd) unless ENV["env"] == "test"
    end
  end
end
