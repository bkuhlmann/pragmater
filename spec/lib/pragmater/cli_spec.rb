# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI do
  describe ".start" do
    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let(:cli) { described_class.start command_line }

    shared_examples_for "an add command" do
      let(:tasks_dir) { File.join temp_dir, "tasks" }
      let(:ruby_file) { File.join temp_dir, "test.rb" }
      let(:rake_file) { File.join tasks_dir, "test.rake" }
      let(:text_file) { File.join temp_dir, "test.txt" }
      before do
        FileUtils.mkdir tasks_dir
        FileUtils.touch [ruby_file, rake_file, text_file]
      end

      context "with a single file", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-i", "test.rb"] }

        it "adds pragma comment to ruby file" do
          cli

          File.open ruby_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end
        end

        it "prints that file was updated" do
          result = -> { cli }
          expect(&result).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end

      context "with multiple files", :temp_dir do
        let :options do
          [temp_dir, "-c", "# frozen_string_literal: true", "-i", "*.rb", "**/*.rake"]
        end

        it "adds pragma comment to selected files", :aggregate_failures do
          cli

          File.open ruby_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end

          File.open rake_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end

          File.open(text_file, "r") { |file| expect(file.readlines).to be_empty }
        end

        it "prints selected files were updated" do
          pattern = /info\s+Processed\:\s#{ruby_file}\.\n\s+info\s+Processed\:\s#{rake_file}\.\n/
          result = -> { cli }

          expect(&result).to output(pattern).to_stdout
        end
      end

      context "with multiple files and included extensions", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-i", "*.rb"] }

        it "adds pragma comment to selected files", :aggregate_failures do
          cli

          File.open ruby_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end

          File.open(rake_file, "r") { |file| expect(file.readlines).to be_empty }
          File.open(text_file, "r") { |file| expect(file.readlines).to be_empty }
        end

        it "prints selected files were updated" do
          result = -> { cli }
          expect(&result).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end
    end

    shared_examples_for "a remove command" do
      let(:tasks_dir) { File.join temp_dir, "tasks" }
      let(:ruby_file) { File.join temp_dir, "test.rb" }
      let(:rake_file) { File.join tasks_dir, "test.rake" }
      let(:text_file) { File.join temp_dir, "test.txt" }
      before do
        FileUtils.mkdir tasks_dir
        [ruby_file, rake_file, text_file].each do |file_path|
          File.open(file_path, "w") { |file| file.write "# frozen_string_literal: true\n" }
        end
      end

      context "with a single file", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-i", "test.rb"] }

        it "adds pragma comment to ruby file" do
          cli
          File.open(ruby_file, "r") { |file| expect(file.readlines).to be_empty }
        end

        it "prints that file was updated" do
          result = -> { cli }
          expect(&result).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end

      context "with multiple files", :temp_dir do
        let :options do
          [temp_dir, "-c", "# frozen_string_literal: true", "-i", "*.rb", "**/*.rake"]
        end

        it "removes pragma comment to selected files", :aggregate_failures do
          cli

          File.open(ruby_file, "r") { |file| expect(file.readlines).to be_empty }
          File.open(rake_file, "r") { |file| expect(file.readlines).to be_empty }
          File.open text_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end
        end

        it "prints selected files were updated" do
          pattern = /info\s+Processed\:\s#{ruby_file}\.\n\s+info\s+Processed\:\s#{rake_file}\.\n/
          result = -> { cli }

          expect(&result).to output(pattern).to_stdout
        end
      end

      context "with multiple files and included extensions", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-i", "*.rb"] }

        it "removes pragma comment from selected files", :aggregate_failures do
          cli

          File.open(ruby_file, "r") { |file| expect(file.readlines).to be_empty }

          File.open rake_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end

          File.open text_file, "r" do |file|
            expect(file.readlines).to contain_exactly("# frozen_string_literal: true\n")
          end
        end

        it "prints selected files were updated" do
          result = -> { cli }
          expect(&result).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end
    end

    shared_examples_for "a config command", :temp_dir do
      context "with no options" do
        it "prints help text" do
          result = -> { cli }
          expect(&result).to output(/Manage gem configuration./).to_stdout
        end
      end
    end

    shared_examples_for "a version command" do
      it "prints version" do
        pattern = /#{Pragmater::Identity.version_label}\n/
        result = -> { cli }

        expect(&result).to output(pattern).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        pattern = /#{Pragmater::Identity.version_label}\scommands:\n/
        result = -> { cli }

        expect(&result).to output(pattern).to_stdout
      end
    end

    describe "--add" do
      let(:command) { "--add" }
      it_behaves_like "an add command"
    end

    describe "-a" do
      let(:command) { "-a" }
      it_behaves_like "an add command"
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
