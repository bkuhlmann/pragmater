# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Writer, :temp_dir do
  let(:test_file_path) { File.join temp_dir, "test.rb" }
  subject { described_class.new test_file_path, comments }
  before { FileUtils.cp fixture_file_path, test_file_path }

  describe "#add" do
    context "when file has comments" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_comments.rb" }
      let(:comments) { "# frozen_string_literal: true" }

      it "formats, adds comments, and spacing to top of file" do
        subject.add
        expect(File.open(test_file_path, "r").to_a.join).to eq(
          "#! /usr/bin/ruby\n" \
          "# frozen_string_literal: true\n" \
          "\n" \
          "puts RUBY_VERSION\n"
        )
      end
    end

    context "when file has comments and spacing" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_comments_and_spacing.rb" }
      let(:comments) { "# frozen_string_literal: true" }

      it "formats and adds comments with no extra spacing to top of file" do
        subject.add
        expect(File.open(test_file_path, "r").to_a.join).to eq(
          "#! /usr/bin/ruby\n" \
          "# frozen_string_literal: true\n" \
          "\n" \
          "puts RUBY_VERSION\n"
        )
      end
    end

    context "when file has no comments" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_nothing.rb" }
      let(:comments) { "# frozen_string_literal: true" }

      it "adds formatted comments to top of file" do
        subject.add
        expect(File.open(test_file_path, "r").to_a).to contain_exactly("# frozen_string_literal: true\n")
      end
    end

    context "when duplicates exist" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_comments.rb" }
      let(:comments) { "#! /usr/bin/ruby" }

      it "does not add duplicates" do
        subject.add
        expect(File.open(test_file_path, "r").to_a.join).to eq(
          "#! /usr/bin/ruby\n" \
          "\n" \
          "puts RUBY_VERSION\n"
        )
      end
    end
  end

  describe "#remove" do
    context "when file has comments" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_comments.rb" }
      let(:comments) { "#! /usr/bin/ruby" }

      it "formats and removes comments" do
        subject.remove
        expect(File.open(test_file_path, "r").to_a.join).to eq("puts RUBY_VERSION\n")
      end
    end

    context "when file has comments and spacing" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_comments_and_spacing.rb" }
      let(:comments) { "#! /usr/bin/ruby" }

      it "formats, removes comments, and removes trailing space" do
        subject.remove
        expect(File.open(test_file_path, "r").to_a.join).to eq("puts RUBY_VERSION\n")
      end
    end

    context "when file has no comments" do
      let(:fixture_file_path) { File.join Dir.pwd, "spec", "fixtures", "with_nothing.rb" }
      let(:comments) { "# frozen_string_literal: true" }

      it "does nothing" do
        subject.remove
        expect(File.open(test_file_path, "r").to_a).to be_empty
      end
    end
  end
end
