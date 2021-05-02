prepend_file "test/test_helper.rb" do <<-'RUBY'
require "simplecov"
SimpleCov.start
RUBY
end
