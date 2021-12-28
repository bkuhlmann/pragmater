# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Configuration::Loader do
  subject(:configuration) { described_class.with_defaults }

  let(:content) { Pragmater::Configuration::Content[comments: [], includes: [], root_dir: "."] }

  describe ".call" do
    it "answers default configuration" do
      expect(described_class.call).to be_a(Pragmater::Configuration::Content)
    end
  end

  describe ".with_defaults" do
    it "answers default configuration" do
      expect(described_class.with_defaults.call).to eq(content)
    end
  end

  describe "#call" do
    it "answers default configuration" do
      expect(configuration.call).to eq(content)
    end
  end
end
