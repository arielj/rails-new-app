module RailsNewApp
  class GitBranchProcessor < Processor
    def configure(config)
      if config[:git_branch].strip != "master" # git inits a `master` branch
        log "Setting main branch name"
        branch_name = config[:git_branch].strip == "" ? "main" : config[:git_branch]
        run_cmnd("git checkout -b #{branch_name}")
      end
    end
  end
end
