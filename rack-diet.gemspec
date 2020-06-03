lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rack/diet/version"

Gem::Specification.new do |spec|
  spec.name = "rack-diet"
  spec.version = Rack::Diet::VERSION
  spec.authors = ["Billetto"]
  spec.homepage = 'https://github.com/gfish/rack-diet'
  spec.email = ["development@billetto.com"]

  spec.summary = %q{Disable CSS3 animations and filter out external JavaScript downloads. Helpful for reliable testing with Capybara.}
  spec.license = "MIT"

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "rack"
end
