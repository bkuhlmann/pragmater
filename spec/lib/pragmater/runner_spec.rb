# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Runner do
  using Refinements::Pathnames
  using Refinements::Structs

  subject(:runner) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    let :test_files do
      [
        temp_dir.join("test.rb"),
        temp_dir.join("task", "test.rake"),
        temp_dir.join("test.txt")
      ]
    end

    before { test_files.each { |path| path.make_ancestors.touch } }

    shared_examples "a runner" do
      it "yields when given a block" do
        kernel = class_spy Kernel
        runner.call(test_configuration) { |path| kernel.print path }

        expect(kernel).to have_received(:print).with(temp_dir.join("test.rb"))
      end

      it "logs error when action is unknown" do
        runner.call configuration.merge!(includes: ["*.rb"])
        expect(logger.reread).to match(/Unknown run action/m)
      end

      it "answers processed files" do
        expect(runner.call(test_configuration)).to contain_exactly(temp_dir.join("test.rb"))
      end
    end

    context "with insert" do
      let :test_configuration do
        configuration.merge! action_insert: true,
                             includes: ["*.rb"],
                             comments: ["# encoding: UTF-8"]
      end

      it_behaves_like "a runner"

      it "modifies a single file with matching extension" do
        runner.call test_configuration
        expect(test_files.map(&:read)).to contain_exactly("", "", "# encoding: UTF-8\n")
      end

      it "modifies multiple files with matching extensions" do
        runner.call test_configuration.merge!(includes: ["*.rb", "*.txt"])

        expect(test_files.map(&:read)).to contain_exactly(
          "",
          "# encoding: UTF-8\n",
          "# encoding: UTF-8\n"
        )
      end

      it "modifies files with matching nested extensions" do
        runner.call test_configuration.merge!(includes: ["**/*.rake"])
        expect(test_files.map(&:read)).to contain_exactly("# encoding: UTF-8\n", "", "")
      end

      it "doesn't modify files when patterns are included" do
        runner.call test_configuration.merge!(includes: [])
        expect(test_files.map(&:read)).to contain_exactly("", "", "")
      end

      it "doesn't modify files when when extensions don't match" do
        runner.call test_configuration.merge!(includes: ["*.md"])
        expect(test_files.map(&:read)).to contain_exactly("", "", "")
      end

      it "doesn't modify files with invalid extensions" do
        runner.call test_configuration.merge!(includes: ["bogus", "~#}*^"])
        expect(test_files.map(&:read)).to contain_exactly("", "", "")
      end
    end

    context "with remove" do
      let :test_configuration do
        configuration.merge! action_remove: true,
                             includes: ["*.rb"],
                             comments: ["# encoding: UTF-8"]
      end

      it_behaves_like "a runner"

      it "modify files with matching extensions" do
        temp_dir.join("test.rb").rewrite { |body| "# encoding: UTF-8\n#{body}" }
        runner.call test_configuration

        expect(test_files.map(&:read)).to contain_exactly("", "", "")
      end
    end
  end
end
