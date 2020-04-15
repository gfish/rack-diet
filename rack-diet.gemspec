lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rack/diet/version"

Gem::Specification.new do |spec|
  spec.name = "rack-diet"
  spec.version = Rack::Diet::VERSION
  spec.authors = ["Billetto"]
  spec.email = ["development@billetto.dk"]

  spec.summary = %q{Disable CSS3 animations and filter out external JavaScript downloads. Helpful for reliable testing with Capybara.}
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "nokogiri"
  spec.add_runtime_dependency "rack"
end
