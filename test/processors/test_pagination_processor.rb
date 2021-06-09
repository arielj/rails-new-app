require "test_helper"

describe "Pagination processor" do
  before do
    @processor = RailsNewApp::PaginationProcessor.new
    @spy = Spy.on(@processor, :apply_template)
  end

  ["pagy", "kaminari", "will_paginate"].each do |gem|
    it "adds #{gem}" do
      config = {pagination: {key: gem}}
      @processor.update_gemfile(config)
  
      assert @spy.has_been_called_with?("#{gem}-gemfile")
    end
  end
end
