require_relative "steps"
require_relative "processors"
require "readline"

module RailsNewApp
  class Runner
    # use option: nil to hide the screen from the main menu
    SCREENS = [
      {option: "1", page: 1, class: AppNameStep},
      {option: "2", page: 1, class: RailsVersionStep},
      {option: "3", page: 1, class: DatabaseStep},
      {option: "4", page: 1, class: TestRunnerStep},
      {option: "5", page: 1, class: JavaScriptFrameworkStep},
      {option: "6", page: 1, class: RubyLinterStep},
      {option: "7", page: 1, class: TemplateEngineStep},
      {option: "8", page: 1, class: FormBuilderStep},
      {option: "9", page: 1, class: PaginationStep},
      {option: "1", page: 2, class: AuthStep},
      {option: nil, class: CodeCoverageStep},
      {option: nil, class: TestFactoryStep},
      {option: nil, class: TestFakeDataStep},
      {option: nil, class: AuthenticationStep},
      {option: nil, class: AuthorizationStep}
    ].freeze

    def get_screen(option)
      case option.to_s
      when /\A\d+\z/
        SCREENS.find { |x| x[:option] == option.to_s && x[:page] == @current_page }
      else
        SCREENS.find { |x| x[:class].key == option.to_sym }
      end
    end

    attr_reader :config

    # entry point
    def run(navigation = true)
      @current_page = 1
      @config = {navigation: navigation}.tap do |h|
        SCREENS.each do |s|
          kls = s[:class]
          h[kls.key] = kls.default
        end
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
        next if s[:page] != @current_page

        screen_name = s[:class].clean_name
        puts "#{s[:option]} : #{screen_name}"
      end
      puts ""
      puts "n : Next menu" if @current_page == 1
      puts "p : Previous menu" if @current_page == 2
      puts "0 : Review and confirm"
      puts ""
      puts "Type the number of the menu and press enter:"
    end

    def show_menu
      print_screens
      loop do
        option = gets.chomp.strip
        case option
        when "0"
          case review_and_confirm
          when :yes then return true
          when :no then return false
          end
          clear
          print_screens
        when "n"
          @current_page += 1
          clear
          print_screens
        when "p"
          @current_page -= 1
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
      config[:rails_version] = RailsVersionStep.run(config)
      config[:database] = DatabaseStep.run(config)
      config[:test_runner] = TestRunnerStep.run(config)

      if config[:test_runner][:key] != ""
        config[:code_coverage] = CodeCoverageStep.run(config)
        config[:test_factory] = TestFactoryStep.run(config)
        config[:test_fake_data] = TestFakeDataStep.run(config)
      end

      config[:js_framework] = JavaScriptFrameworkStep.run(config)
      config[:ruby_linter] = RubyLinterStep.run(config)
      config[:template_engine] = TemplateEngineStep.run(config)
      config[:form_builder] = FormBuilderStep.run(config)
      config[:pagination] = PaginationStep.run(config)
    end

    def review_and_confirm
      clear
      rails_ver = config[:rails_version]
      rails_ver = "Using latest installed Rails version" if rails_ver == ""

      puts <<~REVIEW
        ===== New Rails app config =====
        
        App name: #{config[:app_name]}
        Ruby version: #{RUBY_VERSION}
        Rails version: #{rails_ver}
        Database: #{config[:database]}
        Test runner: #{config[:test_runner]}
        Code coverage: #{config[:code_coverage]}
        Test factories: #{config[:test_factory]}
        Test fake data: #{config[:test_fake_data]}
        JS framework: #{config[:java_script_framework]}
        Ruby Linter: #{config[:ruby_linter]}
        Template engine: #{config[:template_engine]}
        Form builder: #{config[:form_builder]}
        Pagination: #{config[:pagination]}
        Authorization: #{config[:authorization]}
        Authentication: #{config[:authentication]}
        
      REVIEW

      message = "Type 'Y(es)' to confirm, 'B(ack) to go back, or 'N(o)' to abort"
      if config[:app_name] == ""
        puts <<~WARNING
          =====================================
                   App name is required        
          =====================================
          
        WARNING
        message.gsub!("Type 'Y(es)' to confirm, ", "Type ")
      end

      loop do
        puts message
        answer = gets.chomp.strip
        return :yes if /\A*Y(es)?\z/i.match?(answer)
        return :back if /\A*B(ack)?\z/i.match?(answer)
        return :no if /\A*N(o)?\z/i.match?(answer)

        puts "Invalid option."
      end
    end

    def install_rails
      return if config[:rails_version] == ""
      # install the require rails version if needed
      puts "Verifying and installing Rails #{config[:rails_ven]}"
      `gem install rails -v#{config[:rails_version]}`
    end

    def rails_new
      puts "Running Rails new"
      command = build_rails_new_command
      puts command
      system(command)
    end

    def process_config
      # cd into rails app
      Dir.chdir(config[:app_name]) do
        # add different gems
        [
          TestRunnerProcessor,
          CodeCoverageProcessor,
          TestFactoryProcessor,
          TestFakeDataProcessor,
          TemplateEngineProcessor,
          FormBuilderProcessor,
          RubyLinterProcessor,
          PaginationProcessor,
          AuthorizationProcessor,
          AuthentiacationProcessor
        ].each { |p| p.update_gemfile(config) }

        # install gems
        system("bundle install")

        # configure each gem
        [
          TestRunnerProcessor,
          CodeCoverageProcessor,
          TestFactoryProcessor,
          FormBuilderProcessor,
          RubyLinterProcessor,
          PaginationProcessor,
          AuthorizationProcessor,
          AuthentiacationProcessor
        ].each { |p| p.configure(config) }

        after_create
      end
    end

    def after_create
      fix_code_style
      initial_commit
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
        ar << "_#{config[:rails_version]}_" if config[:rails_version] != ""
        # new command
        ar << "new"
        # use desired database
        ar << "--database=#{config[:database][:key]}" if config[:database][:in_rails_new]
        # ignore test if not minitest
        ar << "--skip_test" if config[:test_runner][:key] != "minitest"
        # use desired js framework
        ar << "--webpack=#{config[:java_script_framework][:key]}" if config[:java_script_framework][:in_rails_new]
        # ar << "--skip-javascript"
        # add app name
        ar << config[:app_name]
      end.join(" ")
    end

    def fix_code_style
      case config[:ruby_linter][:key]
      when "rubocop" then system("rubocop -A")
      when "standardrb" then system("standardrb --fix")
      end
    end

    def initial_commit
      system("git add .")
      system("git commit -a -m 'Initial commit'")
    end
  end
end
