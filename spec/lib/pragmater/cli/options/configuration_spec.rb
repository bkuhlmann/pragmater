# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Options::Configuration do
  subject(:options) { described_class.new values }

  let(:values) { {} }

  describe "#call" do
    it "activates edit" do
      options.call.parse! %w[--edit]
      expect(values).to eq(edit: true)
    end

    it "activates info" do
      options.call.parse! %w[--info]
      expect(values).to eq(info: true)
    end

    it "fails with invalid option" do
      parse = -> { options.call.parse! %w[--bogus] }
      expect(&parse).to raise_error(OptionParser::InvalidOption, /--bogus/)
    end
  end
end
