# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Parsers::Flag do
  subject(:parser) { described_class.new configuration.dup }

  include_context "with application dependencies"

  it_behaves_like "a parser"

  describe "#call" do
    it "accepts single comment" do
      expect(parser.call(%w[--comments one])).to have_attributes(comments: %w[one])
    end

    it "accepts multiple comments" do
      expect(parser.call(%w[--comments a,b,c])).to have_attributes(comments: %w[a b c])
    end

    it "accepts single include" do
      expect(parser.call(%w[--includes one])).to have_attributes(includes: %w[one])
    end

    it "accepts multiple includes" do
      expect(parser.call(%w[--includes a,b,c])).to have_attributes(includes: %w[a b c])
    end

    it "fails with missing argument" do
      expectation = proc { parser.call %w[--comments] }
      expect(&expectation).to raise_error(OptionParser::MissingArgument, /--comments/)
    end

    it "fails with invalid option" do
      expectation = proc { parser.call %w[--bogus] }
      expect(&expectation).to raise_error(OptionParser::InvalidOption, /--bogus/)
    end
  end
end
