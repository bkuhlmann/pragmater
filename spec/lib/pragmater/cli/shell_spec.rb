# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Shell do
  using Refinements::Pathnames

  subject(:shell) { described_class.new }

  include_context "with application container"

  describe "#call" do
    let(:test_path) { temp_dir.join "test.rb" }

    let :options do
      [
        temp_dir.to_s,
        "--comments",
        "# frozen_string_literal: true",
        "--includes",
        "*.rb"
      ]
    end

    it "edits configuration" do
      shell.call %w[--config edit]
      expect(kernel).to have_received(:system).with(include("EDITOR"))
    end

    it "views configuration" do
      shell.call %w[--config view]
      expect(kernel).to have_received(:system).with(include("cat"))
    end

    it "inserts pragma into file" do
      test_path.touch
      shell.call options.prepend("--insert")

      expect(test_path.read).to eq("# frozen_string_literal: true\n")
    end

    it "removes pragma from files" do
      test_path.write "# frozen_string_literal: true\n"
      shell.call options.prepend("--remove")

      expect(test_path.read).to eq("")
    end

    it "prints version" do
      expectation = proc { shell.call %w[--version] }
      expect(&expectation).to output(/Pragmater\s\d+\.\d+\.\d+/).to_stdout
    end

    it "prints help (usage)" do
      expectation = proc { shell.call %w[--help] }
      expect(&expectation).to output(/Pragmater.+USAGE.+OPTIONS/m).to_stdout
    end

    it "prints usage when no options are given" do
      expectation = proc { shell.call }
      expect(&expectation).to output(/Pragmater.+USAGE.+OPTIONS.+/m).to_stdout
    end

    it "prints error with invalid option" do
      expectation = proc { shell.call %w[--bogus] }
      expect(&expectation).to output(/invalid option.+bogus/).to_stdout
    end
  end
end
