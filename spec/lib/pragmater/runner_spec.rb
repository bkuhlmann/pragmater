# frozen_string_literal: true

require "spec_helper"
require "refinements/pathnames"

RSpec.describe Pragmater::Runner, :temp_dir do
  using Refinements::Pathnames

  subject(:runner) { described_class.new context }

  let :context do
    Pragmater::Context[
      action: :insert,
      root_dir: temp_dir,
      comments: ["# encoding: UTF-8"]
    ]
  end

  describe ".for" do
    let :attributes do
      {
        action: :insert,
        root_dir: temp_dir,
        comments: ["# encoding: UTF-8"],
        includes: ["*.rb"]
      }
    end

    it "runner with valid attributes" do
      expect(described_class.for(**attributes)).to be_a(described_class)
    end

    it "fails with invalid attribute" do
      expectation = proc { described_class.for(**attributes.merge(bogus: true)) }
      expect(&expectation).to raise_error(ArgumentError, /bogus/)
    end
  end

  describe "#call" do
    let :test_files do
      [
        temp_dir.join("test.rb"),
        temp_dir.join("task", "test.rake"),
        temp_dir.join("test.txt")
      ]
    end

    before { test_files.each(&:make_ancestors).each(&:touch) }

    it "modifies a single with matching extension" do
      context.includes = ["*.rb"]
      runner.call

      expect(test_files.map(&:read)).to contain_exactly("", "", "# encoding: UTF-8\n")
    end

    it "modifies multiple files with matching extensions" do
      context.includes = ["*.rb", "*.txt"]
      runner.call

      expect(test_files.map(&:read)).to contain_exactly(
        "",
        "# encoding: UTF-8\n",
        "# encoding: UTF-8\n"
      )
    end

    it "modifies files with matching nested extensions" do
      context.includes = ["**/*.rake"]
      runner.call

      expect(test_files.map(&:read)).to contain_exactly("# encoding: UTF-8\n", "", "")
    end

    it "doesn't modify files when no files are included" do
      context.includes = []
      runner.call

      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end

    it "doesn't modify files when when extensions don't match" do
      context.includes = ["*.md"]
      runner.call

      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end

    it "doesn't modify files with invalid extensions" do
      context.includes = ["bogus", "~#}*^"]
      runner.call

      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end

    it "answers files processed" do
      context.includes = ["*.rb"]
      expect(runner.call).to contain_exactly(temp_dir.join("test.rb"))
    end
  end
end
