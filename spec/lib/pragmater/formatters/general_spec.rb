# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Formatters::General do
  subject(:formatter) { described_class.new string }

  describe "#call" do
    context "with formatted pragma" do
      let(:string) { "# frozen_string_literal: true" }

      it "answers original pragma" do
        expect(formatter.call).to eq("# frozen_string_literal: true")
      end
    end

    context "with unformatted pragma" do
      let(:string) { "#frozen_string_literal:true" }

      it "answers formatted pragma" do
        expect(formatter.call).to eq("# frozen_string_literal: true")
      end
    end

    context "with numbered encoding" do
      let(:string) { "# encoding: 1234" }

      it "answers original pragma" do
        expect(formatter.call).to eq("# encoding: 1234")
      end
    end

    context "with dashed encoding" do
      let(:string) { "# encoding: ISO-8859-1" }

      it "answers original pragma" do
        expect(formatter.call).to eq("# encoding: ISO-8859-1")
      end
    end

    context "with underscored encoding" do
      let(:string) { "# encoding: ASCII_8BIT" }

      it "answers original pragma" do
        expect(formatter.call).to eq("# encoding: ASCII_8BIT")
      end
    end

    context "with shebang" do
      let(:string) { "#! /usr/bin/ruby" }

      it "answers original pragma" do
        expect(formatter.call).to eq("#! /usr/bin/ruby")
      end
    end

    context "with comment" do
      let(:string) { "# Test." }

      it "answers original comment" do
        expect(formatter.call).to eq("# Test.")
      end
    end
  end
end
