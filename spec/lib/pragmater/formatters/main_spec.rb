# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Formatters::Main do
  subject(:formatter) { described_class.new string }

  describe "#call" do
    context "when general" do
      let(:string) { "# frozen_string_literal: true" }

      it "answers general pragma" do
        expect(formatter.call).to eq("# frozen_string_literal: true")
      end
    end

    context "when shebang" do
      let(:string) { "#! /usr/bin/env ruby" }

      it "answers shebang pragma" do
        expect(formatter.call).to eq("#! /usr/bin/env ruby")
      end
    end

    context "when comment" do
      let(:string) { "# Some random comment." }

      it "answers comment" do
        expect(formatter.call).to eq("# Some random comment.")
      end
    end
  end
end
