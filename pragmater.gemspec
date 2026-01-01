# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "pragmater"
  spec.version = "16.5.0"
  spec.authors = ["Brooke Kuhlmann"]
  spec.email = ["brooke@alchemists.io"]
  spec.homepage = "https://alchemists.io/projects/pragmater"
  spec.summary = "A command line interface for managing pragma comments."
  spec.license = "Hippocratic-2.1"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/pragmater/issues",
    "changelog_uri" => "https://alchemists.io/projects/pragmater/versions",
    "homepage_uri" => "https://alchemists.io/projects/pragmater",
    "funding_uri" => "https://github.com/sponsors/bkuhlmann",
    "label" => "Pragmater",
    "rubygems_mfa_required" => "true",
    "source_code_uri" => "https://github.com/bkuhlmann/pragmater"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = ">= 4.0"
  spec.add_dependency "cogger", "~> 2.0"
  spec.add_dependency "containable", "~> 2.0"
  spec.add_dependency "dry-schema", "~> 1.14"
  spec.add_dependency "etcher", "~> 4.0"
  spec.add_dependency "infusible", "~> 5.0"
  spec.add_dependency "refinements", "~> 14.0"
  spec.add_dependency "runcom", "~> 13.0"
  spec.add_dependency "sod", "~> 2.0"
  spec.add_dependency "spek", "~> 5.0"
  spec.add_dependency "zeitwerk", "~> 2.7"

  spec.bindir = "exe"
  spec.executables << "pragmater"
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.files = Dir["*.gemspec", "lib/**/*"]
end
