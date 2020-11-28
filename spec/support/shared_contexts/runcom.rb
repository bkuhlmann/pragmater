# frozen_string_literal: true

RSpec.shared_context "with Runcom", :runcom do
  using Refinements::Pathnames

  include_context "with temporary directory"

  let :runcom_configuration do
    Runcom::Config.new gem_configuration_path,
                       defaults: gem_defaults,
                       context: Runcom::Context.new(
                         environment: {"HOME" => temp_dir},
                         xdg: XDG::Config
                       )
  end

  let(:gem_configuration_path) { temp_dir.join("configuration.yml").touch }
  let(:gem_defaults) { YAML.load_file Bundler.root.join("lib/pragmater/cli/options/defaults.yml") }
end
