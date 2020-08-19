# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Processors::Inserter do
  subject(:processor) { described_class.new ["# frozen_string_literal: true\n"], body }

  describe "#call" do
    context "when body doesn't start with new line" do
      let(:body) { [%(puts "Test."\n)] }

      it "adds new line between pragmas and body" do
        expect(processor.call).to contain_exactly(
          "# frozen_string_literal: true\n",
          "\n",
          %(puts "Test."\n)
        )
      end
    end

    context "when body starts with new line" do
      let(:body) { ["\n", %(puts "Test."\n)] }

      it "doesn't add new line" do
        expect(processor.call).to contain_exactly(
          "# frozen_string_literal: true\n",
          "\n",
          %(puts "Test."\n)
        )
      end
    end

    context "when body is empty" do
      let(:body) { [] }

      it "doesn't add new line" do
        expect(processor.call).to contain_exactly(
          "# frozen_string_literal: true\n"
        )
      end
    end
  end
end
