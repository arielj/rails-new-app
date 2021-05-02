lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails-new-app/version"

Gem::Specification.new do |spec|
  spec.name = "rails-new-app"
  spec.version = RailsNewApp::VERSION
  spec.authors = ["Ariel Juodziukynas"]
  spec.email = ["arieljuod@gmail.com"]

  spec.summary = "Command-line tool to assist the creation of new Rails apps"
  spec.homepage = "https://github.com/arielj/rails-new-app"

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
