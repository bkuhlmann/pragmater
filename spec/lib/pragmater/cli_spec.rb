# frozen_string_literal: true

require "spec_helper"
require "refinements/pathnames"

RSpec.describe Pragmater::CLI, :temp_dir do
  using Refinements::Pathnames

  describe ".start" do
    subject(:cli) { described_class.start command_line }

    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let(:test_file) { temp_dir.join "test.rb" }

    shared_examples_for "an insert command" do
      let(:options) { [temp_dir.to_s, "-c", "# frozen_string_literal: true", "-i", "test.rb"] }

      before { test_file.touch }

      it "adds pragma to ruby file" do
        cli
        expect(test_file.read).to eq("# frozen_string_literal: true\n")
      end

      it "prints file was updated" do
        result = proc { cli }
        expect(&result).to output(/info\s+Processed:\s#{test_file}\.\n/).to_stdout
      end
    end

    shared_examples_for "a remove command" do
      let(:options) { [temp_dir.to_s, "-c", "# frozen_string_literal: true", "-i", "test.rb"] }

      before { test_file.write "# frozen_string_literal: true\n" }

      it "removes pragma from ruby file" do
        cli
        expect(test_file.read).to be_empty
      end

      it "prints file was updated" do
        expectation = proc { cli }
        expect(&expectation).to output(/info\s+Processed:\s#{test_file}\.\n/).to_stdout
      end
    end

    shared_examples_for "a config command" do
      context "with no options" do
        it "prints help text" do
          expectation = proc { cli }
          expect(&expectation).to output(/Manage gem configuration./).to_stdout
        end
      end
    end

    shared_examples_for "a version command" do
      it "prints version" do
        pattern = /#{Pragmater::Identity::VERSION_LABEL}\n/
        result = proc { cli }

        expect(&result).to output(pattern).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        pattern = /#{Pragmater::Identity::VERSION_LABEL}\scommands:\n/
        result = proc { cli }

        expect(&result).to output(pattern).to_stdout
      end
    end

    describe "--insert" do
      let(:command) { "--insert" }

      it_behaves_like "an insert command"
    end

    describe "-i" do
      let(:command) { "-i" }

      it_behaves_like "an insert command"
    end

    describe "--remove" do
      let(:command) { "--remove" }

      it_behaves_like "a remove command"
    end

    describe "-r" do
      let(:command) { "-r" }

      it_behaves_like "a remove command"
    end

    describe "--config" do
      let(:command) { "--config" }

      it_behaves_like "a config command"
    end

    describe "-c" do
      let(:command) { "-c" }

      it_behaves_like "a config command"
    end

    describe "--version" do
      let(:command) { "--version" }

      it_behaves_like "a version command"
    end

    describe "-v" do
      let(:command) { "-v" }

      it_behaves_like "a version command"
    end

    describe "--help" do
      let(:command) { "--help" }

      it_behaves_like "a help command"
    end

    describe "-h" do
      let(:command) { "-h" }

      it_behaves_like "a help command"
    end

    context "with no command" do
      let(:command) { nil }

      it_behaves_like "a help command"
    end
  end
end
