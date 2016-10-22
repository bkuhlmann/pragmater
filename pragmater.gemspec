# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "pragmater/identity"

Gem::Specification.new do |spec|
  spec.name = Pragmater::Identity.name
  spec.version = Pragmater::Identity.version
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://github.com/bkuhlmann/pragmater"
  spec.summary = "A command line interface for managing/formatting source file pragma comments."
  spec.license = "MIT"

  if File.exist?(Gem.default_key_path) && File.exist?(Gem.default_cert_path)
    spec.signing_key = Gem.default_key_path
    spec.cert_chain = [Gem.default_cert_path]
  end

  spec.required_ruby_version = "~> 2.3"
  spec.add_dependency "thor", "~> 0.19"
  spec.add_dependency "thor_plus", "~> 3.1"
  spec.add_dependency "refinements", "~> 2.2"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "gemsmith", "~> 7.7"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "pry-byebug", "~> 3.4"
  spec.add_development_dependency "pry-state", "~> 0.1"
  spec.add_development_dependency "bond", "~> 0.5"
  spec.add_development_dependency "wirb", "~> 2.0"
  spec.add_development_dependency "hirb", "~> 0.7"
  spec.add_development_dependency "awesome_print", "~> 1.7"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "climate_control", "~> 0.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "rubocop", "~> 0.44"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.6"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "pragmater"
  spec.require_paths = ["lib"]
end
