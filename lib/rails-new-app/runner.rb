require_relative "steps"
require_relative "processors"

module RailsNewApp
  class Runner
    def config
      @config
    end
  
    # entry point
    def run
      intro
      steps
      if confirmation
        install_rails
        rails_new
        process_config
        end_message
        0
      else
        aborted_message
        1
      end
    end
  
    def intro
      puts "Let's create a new Rails app step by step"
  
      @config = {}
    end
  
    def steps
      config[:app_name] = RailsNewApp::AppNameStep.run
      config[:rails_ver] = RailsVersionStep.run
      config[:database] = DatabaseStep.run
      config[:test_runner] = TestRunnerStep.run
  
      # ignore test coverage if no tests
      config[:code_coverage] =
        if config[:test_runner][:key] == ""
          puts "Skipping Simplecov config, no test runner"
          {key: ""}
        else
          CodeCoverageStep.run
        end
  
      config[:js_framework] = JavaScriptFrameworkStep.run
      config[:ruby_linter] = RubyLinterStep.run
      config[:template_engine] = TemplateEngineStep.run
      config[:form_builder] = FormBuilderStep.run
    end
  
    def confirmation
      puts "===== New Rails app config ====="
      puts "App name: #{config[:app_name]}"
      puts "Version: #{config[:rails_ver]}"
      puts "Database: #{config[:database]}"
      puts "Test runner: #{config[:test_runner]}"
      puts "Code coverage: #{config[:code_coverage]}"
      puts "JS framework: #{config[:js_framework]}"
      puts "Ruby Linter: #{config[:ruby_linter]}"
      puts "Template engine: #{config[:template_engine]}"
      puts "Form builder: #{config[:form_builder]}"

      puts "Type 'Y(es)' to confirm or 'N(o)' to abort"
      loop do
        answer = gets.chomp.strip
        return true if answer =~ /\A*y(es)?\z/i
        return false if answer =~ /\A*N(o)?\z/i

        puts "Invalid option, type 'Y(es)' to confirm or 'N(o)' to abort"
      end
    end
  
    def install_rails
      # install the require rails version if needed
      puts "Verifying and installing Rails #{config[:rails_ven]}"
      `gem install rails -v#{config[:rails_ver]}`
    end
  
    def rails_new
      puts "Running Rails new"
      command = build_rails_new_command
      # puts command
      system(command)
    end
  
    def process_config
      # cd into rails app
      Dir.chdir(config[:app_name]) do
        # add different gems
        TestRunnerProcessor.update_gemfile(config)
        CodeCoverageProcessor.update_gemfile(config)
        TemplateEngineProcessor.update_gemfile(config)
        FormBuilderProcessor.update_gemfile(config)
        RubyLinterProcessor.update_gemfile(config)

        # install gems
        system("bundle install")

        #configure each gem
        TestRunnerProcessor.configure(config)
        CodeCoverageProcessor.configure(config)
        TemplateEngineProcessor.configure(config)
        FormBuilderProcessor.configure(config)
        RubyLinterProcessor.configure(config)
      end
    end
  
    def end_message
      puts "Your new Rails app is ready!"
    end
  
    def aborted_message
      puts "Aborted"
    end
  
    private
  
    # final step and creation
    def build_rails_new_command
      ["rails"].tap do |ar|
        # use specific Rails version
        ar << "_#{config[:rails_ver]}_"
        # new command
        ar << "new"
        # use desired database
        ar << "--database=#{config[:database][:key]}" if config[:database][:in_rails_new]
        # ignore test if not minitest
        ar << "--skip_test" if config[:test_runner][:key] != "minitest"
        # use desired js framework
        ar << "--webpack=#{config[:js_framework][:key]}" if config[:js_framework][:in_rails_new]
        # ar << "--skip-javascript"
        # add app name
        ar << config[:app_name]
      end.join(" ")
    end
  end
end
