# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Formatters::Shebang do
  subject(:formatter) { described_class.new string }

  describe "#call" do
    context "with formatted shebang" do
      let(:string) { "#! /usr/bin/env ruby" }

      it "answers original pragma" do
        expect(formatter.call).to eq("#! /usr/bin/env ruby")
      end
    end

    context "with space missing between bang and forward slash" do
      let(:string) { "#!/usr/bin/env ruby" }

      it "answers formatted pragma" do
        expect(formatter.call).to eq("#! /usr/bin/env ruby")
      end
    end

    context "with octothorpe, bang, and path only" do
      let(:string) { "#!/ruby" }

      it "answers formatted pragma" do
        expect(formatter.call).to eq("#! /ruby")
      end
    end

    context "with space between octothorpe and bang" do
      let(:string) { "# ! /usr/bin/env ruby" }

      it "answers original comment" do
        expect(formatter.call).to eq("# ! /usr/bin/env ruby")
      end
    end

    context "with general comment" do
      let(:string) { "# Test." }

      it "answers original comment" do
        expect(formatter.call).to eq("# Test.")
      end
    end
  end
end
