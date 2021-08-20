module RailsNewApp
  class ReviewAndConfirmScreen < Screen
    def screen_text
      rails_ver = ENV["env"] == "test" ? '' : `rails -v`
      rails_ver.gsub!("\n", '')

      [].tap do |ls|
        ls << <<~REVIEW
          ===== New Rails app config =====
          
          # We are using the default versions in your system
          # If you want to use a different version of Ruby or
          # Rails, make sure to install those

          Ruby version: #{RUBY_VERSION}
          Rails version: #{rails_ver}

          App name: #{config[:app_name]}
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
          Git Remote: #{config[:git]}
          CI Config: #{config[:continuous_integration]}

        REVIEW

        message = "Type 'Y(es)' to confirm, 'B(ack) to go back, or 'N(o)' to abort"
        if config[:app_name] == ""
          ls << <<~WARNING
            =====================================
                    App name is required        
            =====================================
            
          WARNING
          message.gsub!("Type 'Y(es)' to confirm, ", "Type ")
        end

        ls << message
      end
    end

    def valid?(input)
      if /\A*Y(es)?\z|\A*B(ack)?\z|\A*N(o)?\z/i.match?(input)
        @error = false
        true
      else
        @error = "Invalid option"
        false
      end
    end

    def next_step
      case @input
      when /\A*B(ack)?\z/i then :menu
      when /\A*Y(es)?\z/i then :finish
      when /\A*N(o)?\z/i then :abort
      else :rerender
      end
    end
  end
end
