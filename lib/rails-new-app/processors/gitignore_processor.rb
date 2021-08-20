module RailsNewApp
  class GitignoreProcessor < Processor
    def configure(config)
      if config[:test_runner][:key] != ""
        log "Add /coverage to .gitignore"
        run_cmnd("echo '\n# ignore test coverage folder\n/coverage/\n' >> ./.gitignore")
      end
    end
  end
end
