# require generic steps first
path = File.expand_path("../steps", __FILE__)
require "#{path}/step"
require "#{path}/choice_step"
require "#{path}/yes_no_choice_step"
# require the rest
Dir.glob("#{path}/*").sort.each { |f| require f }
