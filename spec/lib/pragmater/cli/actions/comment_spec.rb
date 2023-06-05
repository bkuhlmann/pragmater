# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Actions::Comment do
  subject(:action) { described_class.new inputs: }

  let(:inputs) { configuration.dup }

  include_context "with application dependencies"

  describe "#call" do
    it "sets default comments" do
      action.call
      expect(inputs.comments).to eq([])
    end

    it "sets custom comment" do
      action.call ["# frozen_string_literal: true"]
      expect(inputs.comments).to eq(["# frozen_string_literal: true"])
    end

    it "sets custom comments" do
      action.call ["# auto_register: false", "# frozen_string_literal: true"]
      expect(inputs.comments).to eq(["# auto_register: false", "# frozen_string_literal: true"])
    end
  end
end
