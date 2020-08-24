# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Context do
  describe "#initialize" do
    it "answers default attributes" do
      expect(described_class.new).to have_attributes(
        action: nil,
        root_dir: ".",
        comments: [],
        includes: []
      )
    end

    it "answers custom attributes" do
      context = described_class.new action: :insert,
                                    root_dir: "/tmp",
                                    comments: ["# encoding: UTF-8"],
                                    includes: ["*.rb"]

      expect(context).to have_attributes(
        action: :insert,
        root_dir: "/tmp",
        comments: ["# encoding: UTF-8"],
        includes: ["*.rb"]
      )
    end
  end
end
