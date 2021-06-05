module RailsNewApp
  class MenuScreen < Screen
    def initialize(screens)
      @screens = screens
      @current_page = 1
    end

    def get_screen(option)
      SCREENS.find { |x| x[:option] == option.to_s && x[:page] == @current_page }
    end

    def screen_text
      [].tap do |ls|
        @screens.each do |s|
          next if s[:option].nil?
          next if s[:page] != @current_page

          screen_name = s[:class].clean_name
          ls << "#{s[:option]} : #{screen_name}"
        end
        ls << ""
        ls << "n : Next menu" if @current_page == 1
        ls << "p : Previous menu" if @current_page == 2
        ls << "0 : Review and confirm"
        ls << ""
        ls << "Type the number of the menu and press enter:"
      end.join("\n")
    end

    def valid?(input)
      case input
      when "0" then true
      when "n" then @current_page == 1
      when "p" then @current_page == 2
      when /\A\d\z/ then get_screen(input)
      else false
      end
    end

    def go_to_next_page
      @current_page += 1
    end

    def go_to_previous_page
      @current_page -= 1
    end

    def next_step
      case @input
      when "0" then :review_and_confirm
      when "n"
        go_to_next_page
        :rerender
      when "p"
        go_to_previous_page
        :rerender
      else get_screen(@input)[:class].key
      end
    end
  end
end
