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
  spec.license = "Apache-2.0"

  spec.metadata = {
    "bug_tracker_uri" => "https://github.com/bkuhlmann/pragmater/issues",
    "changelog_uri" => "https://www.alchemists.io/projects/pragmater/changes.html",
    "documentation_uri" => "https://www.alchemists.io/projects/pragmater",
    "source_code_uri" => "https://github.com/bkuhlmann/pragmater"
  }

  spec.signing_key = Gem.default_key_path
  spec.cert_chain = [Gem.default_cert_path]

  spec.required_ruby_version = "~> 2.7"
  spec.add_dependency "refinements", "~> 7.16"
  spec.add_dependency "runcom", "~> 6.4"

  spec.files = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README*", "LICENSE*"]
  spec.executables << "pragmater"
  spec.require_paths = ["lib"]
end
