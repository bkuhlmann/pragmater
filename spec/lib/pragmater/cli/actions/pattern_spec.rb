# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Actions::Pattern do
  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "answers default patterns" do
      action.call
      expect(input.patterns).to eq([])
    end

    it "answers custom pattern" do
      action.call [".md"]
      expect(input.patterns).to eq([".md"])
    end

    it "answers custom patterns" do
      action.call [".md", "**/*.md"]
      expect(input.patterns).to eq([".md", "**/*.md"])
    end
  end
end
