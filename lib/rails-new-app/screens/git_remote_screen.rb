module RailsNewApp
  class GitRemoteScreen < Screen
    def screen_text
      "Add your git remote, it will be added to the git configuration of the new app:"
    end

    def next_step
      :menu
    end
  end
end
