# frozen_string_literal: true

require "spec_helper"
require "pragmater/cli"

RSpec.describe Pragmater::CLI do
  describe ".start" do
    let(:options) { [] }
    let(:command_line) { Array(command).concat options }
    let(:cli) { -> { described_class.start command_line } }

    shared_examples_for "an invalid file" do
      let(:corrupt_file_path) { File.join Dir.pwd, "spec", "fixtures", "corrupt.file" }
      let(:options) { [corrupt_file_path, "-c", ""] }

      it "prints error", :temp_dir do
        expect(&cli).to output(/error\s+Invalid\ssource\spath\:\s\"#{corrupt_file_path}\"\./).to_stdout
      end
    end

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
        let(:options) { [ruby_file, "-c", "# frozen_string_literal: true"] }

        it "adds pragma comment to ruby file" do
          cli.call
          expect(File.open(ruby_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
        end

        it "prints that file was updated" do
          expect(&cli).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end

      context "with multiple files", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-w", ".rb", ".rake"] }

        it "adds pragma comment to selected files", :aggregate_failures do
          cli.call

          expect(File.open(ruby_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
          expect(File.open(rake_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
          expect(File.open(text_file, "r").to_a).to be_empty
        end

        it "prints selected files were updated" do
          pattern = /info\s+Processed\:\s#{ruby_file}\.\n\s+info\s+Processed\:\s#{rake_file}\.\n/
          expect(&cli).to output(pattern).to_stdout
        end
      end

      context "with multiple files and whitelisted extensions", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-w", ".rb"] }

        it "adds pragma comment to selected files", :aggregate_failures do
          cli.call

          expect(File.open(ruby_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
          expect(File.open(rake_file, "r").to_a).to be_empty
          expect(File.open(text_file, "r").to_a).to be_empty
        end

        it "prints selected files were updated" do
          expect(&cli).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end

      it_behaves_like "an invalid file"
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
        let(:options) { [ruby_file, "-c", "# frozen_string_literal: true"] }

        it "adds pragma comment to ruby file" do
          cli.call
          expect(File.open(ruby_file, "r").to_a).to be_empty
        end

        it "prints that file was updated" do
          expect(&cli).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end

      context "with multiple files", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-w", ".rb", ".rake"] }

        it "adds pragma comment to selected files", :aggregate_failures do
          cli.call

          expect(File.open(ruby_file, "r").to_a).to be_empty
          expect(File.open(rake_file, "r").to_a).to be_empty
          expect(File.open(text_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
        end

        it "prints selected files were updated" do
          pattern = /info\s+Processed\:\s#{ruby_file}\.\n\s+info\s+Processed\:\s#{rake_file}\.\n/
          expect(&cli).to output(pattern).to_stdout
        end
      end

      context "with multiple files and whitelisted extensions", :temp_dir do
        let(:options) { [temp_dir, "-c", "# frozen_string_literal: true", "-w", ".rb"] }

        it "adds pragma comment to selected files", :aggregate_failures do
          cli.call

          expect(File.open(ruby_file, "r").to_a).to be_empty
          expect(File.open(rake_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
          expect(File.open(text_file, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
        end

        it "prints selected files were updated" do
          expect(&cli).to output(/info\s+Processed\:\s#{ruby_file}\.\n/).to_stdout
        end
      end

      it_behaves_like "an invalid file"
    end

    shared_examples_for "a config command", :temp_dir do
      let(:configuration_path) { File.join temp_dir, Pragmater::Identity.file_name }
      before { FileUtils.touch configuration_path }

      context "with info option" do
        let(:options) { %w[-i] }

        it "prints configuration path" do
          Dir.chdir(temp_dir) do
            expect(&cli).to output("Using: #{configuration_path}.\n").to_stdout
          end
        end
      end

      context "with no options" do
        it "prints help text" do
          expect(&cli).to output(/Manage gem configuration./).to_stdout
        end
      end
    end

    shared_examples_for "a version command" do
      it "prints version" do
        expect(&cli).to output(/#{Pragmater::Identity.label}\s#{Pragmater::Identity.version}\n/).to_stdout
      end
    end

    shared_examples_for "a help command" do
      it "prints usage" do
        expect(&cli).to output(/#{Pragmater::Identity.label}\s#{Pragmater::Identity.version}\scommands:\n/).to_stdout
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
