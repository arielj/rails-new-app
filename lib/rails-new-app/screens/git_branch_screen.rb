module RailsNewApp
  class GitBranchScreen < Screen
    def screen_text
      "Enter the name for the main git branch ('main' by default if left empty):"
    end

    def next_step
      :menu
    end
  end
end
