# frozen_string_literal: true

require "dry/container/stub"
require "auto_injector/stub"

RSpec.shared_context "with application dependencies" do
  using Refinements::Structs
  using AutoInjector::Stub

  include_context "with temporary directory"

  let :configuration do
    Pragmater::Configuration::Loader.with_defaults.call.merge root_dir: temp_dir
  end

  let(:kernel) { class_spy Kernel }

  let :logger do
    Cogger::Client.new Logger.new(StringIO.new),
                       formatter: -> _severity, _name, _at, message { "#{message}\n" }
  end

  before { Pragmater::Import.stub configuration:, kernel:, logger: }

  after { Pragmater::Import.unstub :configuration, :kernel, :logger }
end
