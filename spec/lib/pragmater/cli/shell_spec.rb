# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Shell, :runcom do
  using Refinements::Pathnames

  subject(:shell) { described_class.new merger: merger, helper: helper }

  let(:merger) { Pragmater::CLI::Options::Merger.new runcom_configuration }
  let(:helper) { instance_spy Pragmater::CLI::Helper }

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

    it "edits configuration" do
      shell.call ["--config", "--edit"]
      expect(helper).to have_received(:run).with(/.+\s.+configuration.yml/)
    end

    it "prints configuration when it exists" do
      shell.call ["--config", "--info"]
      expect(helper).to have_received(:info).with(/configuration.yml/)
    end

    context "when configuration doesn't exist" do
      let(:gem_configuration_path) { temp_dir.join "invalid.yml" }

      it "prints configuration not found info" do
        shell.call ["--config", "--info"]
        expect(helper).to have_received(:info).with(/no configuration/i)
      end
    end

    it "displays version" do
      shell.call ["--version"]
      expect(helper).to have_received(:info).with(/\d+\.\d+\.\d+\Z/)
    end

    it "displays help" do
      shell.call ["--help"]
      expect(helper).to have_received(:info).with(/Pragmater.+USAGE.+OPTIONS.+/m)
    end

    it "displays help without any options" do
      shell.call
      expect(helper).to have_received(:info).with(/Pragmater.+USAGE.+OPTIONS.+/m)
    end
  end
end
