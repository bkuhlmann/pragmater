# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Configuration::Model do
  subject(:content) { described_class.new }

  describe "#initialize" do
    it "answers default attributes" do
      expect(content).to have_attributes(comments: [], patterns: [], root_dir: nil)
    end
  end
end
