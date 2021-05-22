module RailsNewApp
  class TestFakeDataProcessor < Processor
    def update_gemfile(config)
      return if config[:test_runner][:key] == ""

      case config[:test_fake_data][:key]
      when "faker" then apply_template "faker-gemfile"
      end
    end
  end
end
