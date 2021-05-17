require_relative "steps"
require_relative "processors"
require "readline"

module RailsNewApp
  class Runner
    # use option: nil to hide the screen from the main menu
    SCREENS = [
      {option: "1", class: AppNameStep},
      {option: "2", class: RailsVersionStep},
      {option: "3", class: DatabaseStep},
      {option: "4", class: TestRunnerStep},
      {option: "5", class: JavaScriptFrameworkStep},
      {option: "6", class: RubyLinterStep},
      {option: "7", class: TemplateEngineStep},
      {option: "8", class: FormBuilderStep},
      {option: nil, class: CodeCoverageStep}
    ].freeze

    def get_screen(option)
      case option.to_s
      when /\A\d+\z/
        SCREENS.find { |x| x[:option] == option.to_s }
      else
        SCREENS.find { |x| x[:class].key == option.to_sym }
      end
    end

    def config
      @config
    end
  
    # entry point
    def run(navigation = true)
      @config = {navigation: navigation}.tap do |h|
        SCREENS.each { |s| kls = s[:class]; h[kls.key] = kls.default }
      end

      intro

      confirmed =
        if navigation
          show_menu
        else
          steps
          review_and_confirm
        end

      if confirmed
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

    def clear
      system("clear")
    end
  
    def intro
      clear
      puts "Let's create a new Rails app step by step"
    end

    def print_screens
      SCREENS.each do |s|
        next if s[:option].nil?

        screen_name = s[:class].clean_name
        puts "#{s[:option]} : #{screen_name}"
      end
      puts "0 : Review and confirm"
      puts ""
      puts "Type the number of the menu and press enter:"
    end


    def show_menu
      print_screens
      loop do
        option = gets.chomp.strip
        if option == "0"
          case review_and_confirm
          when :yes then return true
          when :no then return false
          end
          clear
          print_screens
        else
          show_screen(option)
        end
      end
    end

    def show_screen(option)
      if (s = get_screen(option))
        screen_obj = s[:class].new
        config[s[:class].key] = screen_obj.run(config)
        clear
        screen_obj.next_step ? show_screen(screen_obj.next_step) : print_screens
      else
        puts "Invalid option, select a category:"
      end
    end
  
    def steps
      config[:app_name] = AppNameStep.run(config)
      config[:rails_ver] = RailsVersionStep.run(config)
      config[:database] = DatabaseStep.run(config)
      config[:test_runner] = TestRunnerStep.run(config)
  
      # ignore test coverage if no tests
      config[:code_coverage] =
        if config[:test_runner][:key] == ""
          puts "Skipping Simplecov config, no test runner"
          {key: ""}
        else
          CodeCoverageStep.run(config)
        end
  
      config[:js_framework] = JavaScriptFrameworkStep.run(config)
      config[:ruby_linter] = RubyLinterStep.run(config)
      config[:template_engine] = TemplateEngineStep.run(config)
      config[:form_builder] = FormBuilderStep.run(config)
    end
  
    def review_and_confirm
      clear
      rails_ver = config[:rails_ver]
      rails_ver = "Using latest installed Rails version" if rails_ver == ""

      puts <<-REVIEW
===== New Rails app config =====

App name: #{config[:app_name]}
Ruby version: #{RUBY_VERSION}
Rails version: #{rails_ver}
Database: #{config[:database]}
Test runner: #{config[:test_runner]}
Code coverage: #{config[:code_coverage]}
JS framework: #{config[:js_framework]}
Ruby Linter: #{config[:ruby_linter]}
Template engine: #{config[:template_engine]}
Form builder: #{config[:form_builder]}

REVIEW

      message = "Type 'Y(es)' to confirm, 'B(ack) to go back, or 'N(o)' to abort"
      if config[:app_name] == ""
        puts <<-WARNING
=====================================
         App name is required        
=====================================

WARNING
        message.gsub!("Type 'Y(es)' to confirm, ", "Type ")
      end

      loop do
        puts message
        answer = gets.chomp.strip
        return :yes if answer =~ /\A*Y(es)?\z/i
        return :back if answer =~ /\A*B(ack)?\z/i
        return :no if answer =~ /\A*N(o)?\z/i

        puts "Invalid option."
      end
    end
  
    def install_rails
      return if config[:rails_ver] == ""
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
        ar << "_#{config[:rails_ver]}_" if config[:rails_ver] != ""
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
