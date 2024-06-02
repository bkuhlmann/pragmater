# frozen_string_literal: true

RSpec.shared_context "with application dependencies" do
  using Refinements::Struct

  include_context "with temporary directory"

  let(:settings) { Pragmater::Container[:settings] }
  let(:kernel) { class_spy Kernel }
  let(:logger) { Cogger.new id: :pragmater, io: StringIO.new }

  before do
    settings.merge! Etcher.call(
      Pragmater::Container[:registry].remove_loader(1),
      root_dir: temp_dir
    )

    Pragmater::Container.stub! kernel:, logger:
  end

  after { Pragmater::Container.restore }
end
