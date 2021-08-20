module RailsNewApp
  class GitProcessor < Processor
    def configure(config)
      puts "Adding git remote"
      if config[:git].strip != ""
        system("git remote add origin #{config[:git]}")
      end
    end
  end
end
