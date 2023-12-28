# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Inserter do
  using Refinements::Pathname
  using Refinements::Struct

  subject(:inserter) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    let :test_files do
      [
        temp_dir.join("test.rb"),
        temp_dir.join("task", "test.rake"),
        temp_dir.join("test.txt")
      ]
    end

    let :test_configuration do
      configuration.merge! comments: ["# encoding: UTF-8"], patterns: ["*.rb"]
    end

    before { test_files.each { |path| path.make_ancestors.touch } }

    it "yields when given a block" do
      kernel = class_spy Kernel
      inserter.call(test_configuration) { |path| kernel.print path }

      expect(kernel).to have_received(:print).with(temp_dir.join("test.rb"))
    end

    it "answers processed files" do
      expect(inserter.call(test_configuration)).to contain_exactly(temp_dir.join("test.rb"))
    end

    it "modifies a single file with matching extension" do
      inserter.call test_configuration
      expect(test_files.map(&:read)).to contain_exactly("", "", "# encoding: UTF-8\n")
    end

    it "modifies multiple files with matching extensions" do
      inserter.call test_configuration.merge!(patterns: ["*.rb", "*.txt"])

      expect(test_files.map(&:read)).to contain_exactly(
        "",
        "# encoding: UTF-8\n",
        "# encoding: UTF-8\n"
      )
    end

    it "modifies files with matching nested extensions" do
      inserter.call test_configuration.merge!(patterns: ["**/*.rake"])
      expect(test_files.map(&:read)).to contain_exactly("# encoding: UTF-8\n", "", "")
    end

    it "doesn't modify files when patterns are included" do
      inserter.call test_configuration.merge!(patterns: [])
      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end

    it "doesn't modify files when when extensions don't match" do
      inserter.call test_configuration.merge!(patterns: ["*.md"])
      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end

    it "doesn't modify files with invalid extensions" do
      inserter.call test_configuration.merge!(patterns: ["bogus", "~#}*^"])
      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end
  end
end
