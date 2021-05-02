inject_into_file "spec/spec_helper.rb", before: "RSpec.configure do |config|\n" do <<-'RUBY'
require "simplecov"
SimpleCov.start
RUBY
end
