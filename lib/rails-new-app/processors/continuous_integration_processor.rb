require 'fileutils'

module RailsNewApp
  class ContinuousIntegrationProcessor < Processor
    def configure(config)
      log "Processing Code Coverage config"
      if config[:continuous_integration][:key] == "github_actions"
        log "Adding Github Actions base config"
        file_content = File.read(File.join(TEMPLATES_PATH, "ci_github_actions.yml"))

        file_content.gsub!("<RUBY_VERSION>", RUBY_VERSION)

        test_steps =
          case config[:test_runner][:key]
          when "rspec" then <<-TEST_STEPS
      - name: Run Tests
        run: bundle exec rails spec
TEST_STEPS

          when "minitest" then <<-TEST_STEPS
      - name: Run Unit Tests
        run: bundle exec rails test
      - name: Run System Tests
        run: bundle exec rails test:system
TEST_STEPS
          else
            ""
          end
        
        file_content.gsub!("<TEST_STEPS>", test_steps)

        branch_name = config[:git_branch].strip == "" ? "main" : config[:git_branch]

        file_content.gsub!("<BRANCH_NAME>", branch_name)

        workflows_dir = File.join(Dir.pwd, ".github", "workflows")
        FileUtils.mkdir_p(workflows_dir)
        file_path = File.join(workflows_dir, "tests.yml")
        File.open(file_path, 'w') { |file| file.write(file_content) }
      end
    end
  end
end
