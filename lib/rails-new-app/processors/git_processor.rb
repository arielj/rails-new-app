module RailsNewApp
  class GitProcessor < Processor
    def configure(config)
      if config[:git].strip != ""
        log "Adding git remote"
        system("git remote add origin #{config[:git]}")
      end
    end
  end
end
