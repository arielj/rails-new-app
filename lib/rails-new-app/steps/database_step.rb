module RailsNewApp
  class DatabaseStep < ChoiceStep
    def rails_new_options
      %W[mysql postgresql sqlite3 oracle sqlserver jdbcmysql jdbcsqlite3 jdbcpostgresql jdbc]
    end

    def options
      ["None", "SQLite", "MySQL / MariaDB", "PostgreSQL"]
    end

    def lowercase_keys
      ["", "sqlite3", "mysql", "postgresql"]
    end

    def step_question
      "Type the option number of the database to use:"
    end

    def after_valid
      puts "Selected database is: #{option}\n"
    end

    def return_value
      super.tap do |h|
        h[:in_rails_new] = rails_new_options.include?(h[:key])
      end
    end

    def self.default
      {
        option_number: "1",
        name: "SQLite",
        key: "sqlite3",
        in_rails_new: true
      }
    end
  end
end
