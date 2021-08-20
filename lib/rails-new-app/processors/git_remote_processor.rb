module RailsNewApp
  class GitRemoteProcessor < Processor
    def configure(config)
      if config[:git_remote].strip != ""
        log "Adding git remote"
        run_cmnd("git remote add origin #{config[:git_remote]}")
      end
    end
  end
end
