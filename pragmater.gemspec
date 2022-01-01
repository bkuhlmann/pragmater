# frozen_string_literal: true

require_relative "lib/pragmater/identity"

Gem::Specification.new do |spec|
  spec.name = Pragmater::Identity::NAME
  spec.version = Pragmater::Identity::VERSION
  spec.platform = Gem::Platform::RUBY
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://www.alchemists.io/projects/pragmater"
  spec.summary = Pragmater::Identity::SUMMARY
  spec.license = "Hippocratic-3.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/pragmater/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/pragmater/versions",
    "documentation_uri" => "https://www.alchemists.io/projects/pragmater",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/pragmater"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 3.1"
  spec.add_dependency "dry-container", "~> 0.9"
  spec.add_dependency "refinements", "~> 9.0"
  spec.add_dependency "runcom", "~> 8.0"
  spec.add_dependency "zeitwerk", "~> 2.5"

  spec.bindir = "exe"
  spec.executables << "pragmater"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["lib/**/*"]
  spec.require_paths = ["lib"]
end
