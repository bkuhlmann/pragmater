# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Shell do
  using Refinements::Pathname
  using Refinements::Struct
  using Refinements::StringIO

  subject(:shell) { described_class.new }

  include_context "with application dependencies"

  before { Sod::Container.stub! logger:, io: }

  after { Sod::Container.restore }

  describe "#call" do
    let(:test_path) { temp_dir.join "test.rb" }

    let :options do
      [
        "--root",
        temp_dir.to_s,
        "--comments",
        "# frozen_string_literal: true",
        "--patterns",
        "*.rb"
      ]
    end

    it "prints configuration usage" do
      shell.call %w[config]
      expect(io.reread).to match(/Manage configuration.+/m)
    end

    it "inserts pragma into file" do
      test_path.touch
      shell.call options.prepend("insert")

      expect(test_path.read).to eq("# frozen_string_literal: true\n")
    end

    it "removes pragma from files" do
      test_path.write "# frozen_string_literal: true\n"
      shell.call options.prepend("remove")

      expect(test_path.read).to eq("")
    end

    it "prints version" do
      shell.call %w[--version]
      expect(io.reread).to match(/Pragmater\s\d+\.\d+\.\d+/)
    end

    it "prints help" do
      shell.call %w[--help]
      expect(io.reread).to match(/Pragmater.+USAGE.+/m)
    end
  end
end
