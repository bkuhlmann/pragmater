# frozen_string_literal: true

require "dry/container/stub"
require "infusible/stub"

RSpec.shared_context "with application dependencies" do
  using Refinements::Structs
  using Infusible::Stub

  include_context "with temporary directory"

  let :configuration do
    Pragmater::Configuration::Loader.with_defaults.call.merge root_dir: temp_dir
  end

  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new io: StringIO.new, formatter: :emoji }

  before { Pragmater::Import.stub configuration:, kernel:, logger: }

  after { Pragmater::Import.unstub :configuration, :kernel, :logger }
end
