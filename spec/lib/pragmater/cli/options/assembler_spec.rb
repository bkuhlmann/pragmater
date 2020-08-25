# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Options::Assembler do
  subject(:handler) { described_class.new }

  describe "#call" do
    it "answers empty hash by default" do
      expect(handler.call).to eq({})
    end

    it "answers assembled options when given options" do
      expect(handler.call(%w[--help])).to eq(help: true)
    end

    it "answers empty hash with invalid argument" do
      expect(handler.call(%w[--bogus])).to eq({})
    end
  end
end
