# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Actions::Run do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:action) { described_class.new }

  include_context "with application container"

  describe "#call" do
    let(:test_path) { temp_dir.join("test.rb") }

    let :test_configuration do
      configuration.merge! action_insert: true, includes: ["*.rb"], comments: ["# encoding: UTF-8"]
    end

    before { test_path.touch }

    it "logs runner activity" do
      action.call test_configuration
      expect(logger.reread).to eq("#{test_path}\n")
    end
  end
end
