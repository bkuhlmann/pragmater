# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Processors::Remover do
  subject(:processor) { described_class.new comments, body }

  describe "#call" do
    context "when comments are empty and body starts with new line" do
      let(:comments) { [] }
      let(:body) { ["\n", %(puts "Test."\n)] }

      it "deletes new line" do
        expect(processor.call).to contain_exactly(%(puts "Test."\n))
      end
    end

    context "when comments are empty and body doesn't start with new line" do
      let(:comments) { [] }
      let(:body) { [%(puts "Test."\n)] }

      it "doesn't delete any line" do
        expect(processor.call).to contain_exactly(%(puts "Test."\n))
      end
    end

    context "when comments exist and body starts with new line" do
      let(:comments) { ["#! /usr/bin/env ruby\n"] }
      let(:body) { ["\n", %(puts "Test."\n)] }

      it "doesn't delete any line" do
        expect(processor.call).to contain_exactly(
          "#! /usr/bin/env ruby\n",
          "\n",
          %(puts "Test."\n)
        )
      end
    end
  end
end
