require_relative "screens"
require_relative "processors"
require "readline"
require "byebug"

module RailsNewApp
  # use option: nil to hide the screen from the main menu
  SCREENS = [
    {option: "1", page: 1, class: AppNameScreen},
    {option: "2", page: 1, class: DatabaseScreen},
    {option: "3", page: 1, class: TestRunnerScreen},
    {option: "4", page: 1, class: JavaScriptFrameworkScreen},
    {option: "5", page: 1, class: RubyLinterScreen},
    {option: "6", page: 1, class: TemplateEngineScreen},
    {option: "7", page: 1, class: FormBuilderScreen},
    {option: "8", page: 1, class: PaginationScreen},
    {option: "1", page: 2, class: AuthScreen},
    {option: "2", page: 2, class: GitScreen},
    {option: nil, class: CodeCoverageScreen},
    {option: nil, class: TestFactoryScreen},
    {option: nil, class: TestFakeDataScreen},
    {option: nil, class: AuthenticationScreen},
    {option: nil, class: AuthorizationScreen}
  ].freeze

  class Runner
    attr_accessor :config, :current_page, :current_screen, :menu

    def initialize(navigation: true)
      @menu = MenuScreen.new SCREENS
      @current_screen = @menu
      @navigation = navigation
      @config = {}.tap do |h|
        SCREENS.each do |s|
          kls = s[:class]
          h[kls.key] = kls.default
        end
      end
    end

    # entry point
    def run
      intro

      confirmation =
        if @navigation
          start
        else
          steps
          review_and_confirm
        end

      if confirmation == :finish
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
      clear
      puts "Let's create a new Rails app step by step"
    end

    def show_current_screen
      puts current_screen.screen_text
    end

    def start
      next_do = nil

      loop do
        show_current_screen
        option = gets.chomp.strip

        next_do = process_user_input(option)
        case next_do
        when :finish, :abort then break
        end
        clear
      end

      next_do
    end

    def process_user_input(option)
      next_step, new_config = @current_screen.process_user_input(option)

      if new_config
        @config[@current_screen.class.key] = new_config
      end

      case next_step
      when :menu then @current_screen = @menu
      when :review_and_confirm then @current_screen = ReviewAndConfirmScreen.new(config)
      when :finish, :abort, :rerender then next_step
      else
        @current_screen = get_screen(next_step).new(config)
      end
    end

    def steps
      config[:app_name] = AppNameScreen.run(config)
      config[:database] = DatabaseScreen.run(config)
      config[:test_runner] = TestRunnerScreen.run(config)

      if config[:test_runner][:key] != ""
        config[:code_coverage] = CodeCoverageScreen.run(config)
        config[:test_factory] = TestFactoryScreen.run(config)
        config[:test_fake_data] = TestFakeDataScreen.run(config)
      end

      config[:js_framework] = JavaScriptFrameworkScreen.run(config)
      config[:ruby_linter] = RubyLinterScreen.run(config)
      config[:template_engine] = TemplateEngineScreen.run(config)
      config[:form_builder] = FormBuilderScreen.run(config)
      config[:pagination] = PaginationScreen.run(config)
    end

    def rails_new
      puts "Running Rails new"
      command = build_rails_new_command
      puts command
      run_cmnd(command)
    end

    def update_gemfile
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
        AuthenticationProcessor
      ].each { |p| p.update_gemfile(config) }
    end

    def apply_configuration
      [
        TestRunnerProcessor,
        CodeCoverageProcessor,
        TestFactoryProcessor,
        FormBuilderProcessor,
        RubyLinterProcessor,
        PaginationProcessor,
        AuthorizationProcessor,
        AuthenticationProcessor,
        GitProcessor
      ].each { |p| p.configure(config) }
    end

    def process_config
      # cd into rails app
      Dir.chdir(config[:app_name]) do
        update_gemfile

        # install gems
        run_cmnd("bundle install")

        apply_configuration

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

    # final step and creation
    def build_rails_new_command
      ["rails"].tap do |ar|
        # new command
        ar << "new"
        # use desired database
        ar << "--database=#{config[:database][:key]}" if config[:database][:in_rails_new] && !config[:database][:is_default]
        # ignore test if not minitest
        ar << "--skip-test" if config[:test_runner][:key] != "minitest"
        # use desired js framework
        ar << "--webpack=#{config[:java_script_framework][:key]}" if config[:java_script_framework][:in_rails_new]
        # ar << "--skip-javascript"
        # add app name
        ar << "--minimal"
        ar << config[:app_name]
      end.join(" ")
    end

    def fix_code_style
      case config[:ruby_linter][:key]
      when "rubocop" then run_cmnd("rubocop -A")
      when "standardrb" then run_cmnd("standardrb --fix")
      end
    end

    def initial_commit
      run_cmnd("git add .")
      run_cmnd("git commit -a -m 'Initial commit'")
    end

    private

    def clear
      run_cmnd("clear")
    end

    def run_cmnd(cmd)
      system(cmd) unless ENV["env"] == "test"
    end

    def get_screen(key)
      SCREENS.find { |x| x[:class].key == key.to_sym }[:class]
    end
  end
end
