# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Parsers::File, :temp_dir do
  subject(:parser) { described_class.new }

  let(:test_path) { temp_dir.join "test.rb" }

  before { FileUtils.cp fixture_path, test_path }

  describe "#call" do
    context "when adding to file with existing comments" do
      let(:fixture_path) { Bundler.root.join "spec", "fixtures", "with_comments.rb" }

      it "formats, adds comments, and spacing to top of file" do
        body = parser.call test_path, "# frozen_string_literal: true", action: :insert

        expect(body).to contain_exactly(
          "#! /usr/bin/env ruby\n",
          "# frozen_string_literal: true\n",
          "\n",
          "puts RUBY_VERSION\n"
        )
      end
    end

    context "when adding to file with existing comments and spacing" do
      let(:fixture_path) { Bundler.root.join "spec", "fixtures", "with_comments_and_spacing.rb" }

      it "formats and adds comments with no extra spacing to top of file" do
        body = parser.call test_path, "# frozen_string_literal: true", action: :insert

        expect(body).to contain_exactly(
          "#! /usr/bin/env ruby\n",
          "# frozen_string_literal: true\n",
          "\n",
          "puts RUBY_VERSION\n"
        )
      end
    end

    context "when adding to file with no comments" do
      let(:fixture_path) { Pathname "/dev/null" }

      it "adds formatted comments to top of file" do
        body = parser.call test_path, "# frozen_string_literal: true", action: :insert
        expect(body).to contain_exactly("# frozen_string_literal: true\n")
      end
    end

    context "when adding to file with duplicates" do
      let(:fixture_path) { Bundler.root.join "spec", "fixtures", "with_comments.rb" }

      it "does not add duplicates" do
        body = parser.call test_path, "#! /usr/bin/env ruby", action: :insert

        expect(body).to contain_exactly(
          "#! /usr/bin/env ruby\n",
          "\n",
          "puts RUBY_VERSION\n"
        )
      end
    end

    context "when removing from file with existing comments" do
      let(:fixture_path) { Bundler.root.join "spec", "fixtures", "with_comments.rb" }

      it "formats and removes comments" do
        body = parser.call test_path, "#! /usr/bin/env ruby", action: :remove
        expect(body).to contain_exactly("puts RUBY_VERSION\n")
      end
    end

    context "when removing from file with existing comments and spacing" do
      let(:fixture_path) { Bundler.root.join "spec", "fixtures", "with_comments_and_spacing.rb" }

      it "formats, removes comments, and removes trailing space" do
        body = parser.call test_path, "#! /usr/bin/env ruby", action: :remove
        expect(body).to contain_exactly("puts RUBY_VERSION\n")
      end
    end

    context "when remmoving from file with no comments" do
      let(:fixture_path) { Pathname "/dev/null" }

      it "does nothing" do
        body = parser.call test_path, "# frozen_string_literal: true", action: :remove
        expect(body).to be_empty
      end
    end
  end
end
