# frozen_string_literal: true

RSpec.shared_examples "a parser" do
  describe ".call" do
    it "answers configuration" do
      expect(described_class.call).to be_a(Pragmater::Configuration::Model)
    end
  end
end
