# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Processors::Handler do
  subject(:handler) { described_class.new }

  describe "#call" do
    it "handles insertion processing" do
      comments = ["# frozen_string_literal: true\n"]
      body = [%(puts "Test."\n)]

      expect(handler.call(:insert, comments, body)).to contain_exactly(
        "# frozen_string_literal: true\n",
        "\n",
        %(puts "Test."\n)
      )
    end

    it "handles removal processing" do
      comments = []
      body = ["\n", %(puts "Test."\n)]

      expect(handler.call(:remove, comments, body)).to contain_exactly(%(puts "Test."\n))
    end

    it "fails with key error for unknown action" do
      expectation = proc { handler.call :bogus, [], [] }
      expect(&expectation).to raise_error(KeyError, /bogus/)
    end
  end
end
