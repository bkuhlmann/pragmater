# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Options::Core do
  subject(:options) { described_class.new values }

  let(:values) { {} }

  describe "#call" do
    it "enables configuration (short)" do
      options.call.parse! %w[-c]
      expect(values).to eq(config: true)
    end

    it "enables configuration (long)" do
      options.call.parse! %w[--config]
      expect(values).to eq(config: true)
    end

    it "answers insert (short)" do
      options.call.parse! %w[-i]
      expect(values).to eq(insert: ".")
    end

    it "answers insert (long)" do
      options.call.parse! %w[--insert]
      expect(values).to eq(insert: ".")
    end

    it "answers insert path when given custom path" do
      options.call.parse! %w[--insert a/b/c]
      expect(values).to eq(insert: "a/b/c")
    end

    it "answers remove (short)" do
      options.call.parse! %w[-r]
      expect(values).to eq(remove: ".")
    end

    it "answers remove (long)" do
      options.call.parse! %w[--remove]
      expect(values).to eq(remove: ".")
    end

    it "answers remove path when given custom path" do
      options.call.parse! %w[--remove a/b/c]
      expect(values).to eq(remove: "a/b/c")
    end

    it "answers version (short)" do
      options.call.parse! %w[-v]
      expect(values).to match(version: /\d+\.\d+\.\d+/)
    end

    it "answers version (long)" do
      options.call.parse! %w[--version]
      expect(values).to match(version: /\d+\.\d+\.\d+/)
    end

    it "enables help (short)" do
      options.call.parse! %w[-h]
      expect(values).to eq(help: true)
    end

    it "enables help (long)" do
      options.call.parse! %w[--help]
      expect(values).to eq(help: true)
    end
  end
end
