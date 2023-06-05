# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Infusible::Stub

  include_context "with temporary directory"

  let :configuration do
    Etcher.new(Pragmater::Container[:defaults]).call(root_dir: temp_dir).bind(&:dup)
  end

  let(:xdg_config) { Runcom::Config.new Pragmater::Container[:defaults_path] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new io: StringIO.new, formatter: :emoji }

  before { Pragmater::Import.stub configuration:, xdg_config:, kernel:, logger: }

  after { Pragmater::Import.unstub :configuration, :xdg_config, :kernel, :logger }
end
