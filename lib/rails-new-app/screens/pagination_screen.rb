module RailsNewApp
  class PaginationScreen < ChoiceScreen
    def step_question
      "Type the option number of the Pagination gem to use:"
    end

    def options
      ["None", "Pagy", "Kaminari", "WillPaginate"]
    end

    def lowercase_keys
      ["", "pagy", "kaminari", "will_paginate"]
    end

    def after_valid
      puts "Selected pagination gem is: #{option}\n"
    end

    def self.default
      {
        option_number: 0,
        name: "None",
        key: ""
      }
    end
  end
end
