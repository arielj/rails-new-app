lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails-new-app/version"

Gem::Specification.new do |s|
  s.name = "rails-new-app"
  s.version = RailsNewApp::VERSION
  s.authors = ["Ariel Juodziukynas"]
  s.email = ["arieljuod@gmail.com"]
  s.license = 'MIT'

  s.summary = "Command-line tool to assist the creation of new Rails apps"
  s.homepage = "https://github.com/arielj/rails-new-app"

  s.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir = "exe"
  s.executables = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
end
