module RailsNewApp
  class PaginationProcessor < Processor
    def update_gemfile(config)
      case config[:pagination][:key]
      when "pagy" then apply_template "pagy-gemfile"
      when "kaminari" then apply_template "kaminari-gemfile"
      when "will_paginate" then apply_template "will_paginate-gemfile"
      end
    end

    def configure(config)
      log "Processing Pagination config"
      case config[:pagination][:key]
      when "pagy" then apply_template "pagy-config"
      end
    end
  end
end
