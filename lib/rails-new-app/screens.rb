# require generic screens first
path = File.expand_path("../screens", __FILE__)
require "#{path}/screen"
require "#{path}/choice_screen"
require "#{path}/yes_no_choice_screen"
require "#{path}/menu_screen"
# require the rest
Dir.glob("#{path}/*").sort.each { |f| require f }
