# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Options::InsertRemove do
  subject(:options) { described_class.new values }

  let(:values) { {} }

  describe "#call" do
    it "accepts single comment" do
      options.call.parse! %w[--comments one]
      expect(values).to eq(comments: %w[one])
    end

    it "accepts multiple comments" do
      options.call.parse! %w[--comments one,two,three]
      expect(values).to eq(comments: %w[one two three])
    end

    it "fails with missing argument" do
      parse = proc { options.call.parse! %w[--comments] }
      expect(&parse).to raise_error(OptionParser::MissingArgument, /--comments/)
    end

    it "fails with invalid option" do
      parse = proc { options.call.parse! %w[--bogus] }
      expect(&parse).to raise_error(OptionParser::InvalidOption, /--bogus/)
    end
  end
end
