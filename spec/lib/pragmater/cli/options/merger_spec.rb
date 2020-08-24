# frozen_string_literal: true

require "spec_helper"
require "refinements/pathnames"

RSpec.describe Pragmater::CLI::Options::Merger, :runcom do
  using Refinements::Pathnames

  subject(:resolver) { described_class.new runcom_configuration }

  let :defaults do
    {
      insert: {
        comments: [],
        includes: []
      },
      remove: {
        comments: [],
        includes: []
      }
    }
  end

  describe "#call" do
    context "with insert arguments" do
      it "answers insert hash" do
        arguments = ["--insert", "--comments", "# encoding: UTF-8", "--includes", "*.rb"]

        expect(resolver.call(arguments)).to eq(
          insert: ".",
          comments: ["# encoding: UTF-8"],
          includes: ["*.rb"]
        )
      end
    end

    context "with remove arguments" do
      it "answers remove hash" do
        arguments = ["--remove", "--comments", "# encoding: UTF-8", "--includes", "*.rb"]

        expect(resolver.call(arguments)).to eq(
          remove: ".",
          comments: ["# encoding: UTF-8"],
          includes: ["*.rb"]
        )
      end
    end

    context "with non-insert or non-remove arguments" do
      it "answers remove hash" do
        expect(resolver.call(["--help"])).to eq(help: true)
      end
    end

    context "with empty arguments" do
      it "answers empty hash" do
        expect(resolver.call).to eq({})
      end
    end
  end

  describe "#congiguration_path" do
    it "answers configuration path" do
      expect(resolver.configuration_path).to eq(gem_configuration_path)
    end
  end

  describe "#usage" do
    it "answers somethings" do
      expect(resolver.usage).to match(/usage/i)
    end
  end
end
