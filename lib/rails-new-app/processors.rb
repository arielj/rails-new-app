# require generic steps first
path = File.expand_path("../processors", __FILE__)
require "#{path}/processor"
# require the rest
Dir.glob("#{path}/*").sort.each { |f| require f }
