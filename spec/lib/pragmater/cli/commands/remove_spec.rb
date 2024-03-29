# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Commands::Remove do
  using Refinements::Struct
  using Refinements::Pathname

  subject(:command) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "calls runner with default arguments" do
      expectation = proc { command.call }
      expect(&expectation).to output("").to_stdout
    end

    it "calls runner with custom arguments" do
      path = temp_dir.join("test.md").touch
      input.patterns = %w[*.md]
      command.call

      expect(kernel).to have_received(:puts).with(path)
    end
  end
end
