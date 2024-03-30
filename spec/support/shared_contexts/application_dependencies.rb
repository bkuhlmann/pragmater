# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  include_context "with temporary directory"

  let :configuration do
    Etcher.new(Pragmater::Container[:defaults]).call(root_dir: temp_dir).bind(&:dup)
  end

  let(:input) { configuration.dup }
  let(:xdg_config) { Runcom::Config.new Pragmater::Container[:defaults_path] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new id: :pragmater, io: StringIO.new }

  before { Pragmater::Container.stub! configuration:, input:, xdg_config:, kernel:, logger: }

  after { Pragmater::Container.restore }
end
