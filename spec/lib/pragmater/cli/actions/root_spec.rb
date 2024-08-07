# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Actions::Root do
  subject(:action) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    it "answers default root directory" do
      action.call
      expect(settings.root_dir).to eq(temp_dir)
    end

    it "answers custom root directory" do
      action.call "a/path"
      expect(settings.root_dir).to eq(Pathname("a/path"))
    end
  end
end
