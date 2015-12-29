require "spec_helper"

RSpec.describe Pragmater::Formatter do
  describe ".shebang_format" do
    it "matches formatted comment" do
      expect(described_class.shebang_format).to match("#! /usr/bin/ruby")
    end

    it "matches unformatted comment" do
      expect(described_class.shebang_format).to match("#!/usr/bin/ruby")
    end

    it "matches minimal path" do
      expect(described_class.shebang_format).to match("#!/ruby")
    end

    it "does not match when space exists between comment and bang symbol" do
      expect(described_class.shebang_format).to_not match("# ! /usr/bin/ruby")
    end

    it "does not match normal comments" do
      expect(described_class.shebang_format).to_not match("# This is a normal comment.")
    end
  end

  describe ".pragma_format" do
    it "matches formatted comment" do
      expect(described_class.pragma_format).to match("# frozen_string_literal: true")
    end

    it "matches unformatted comment" do
      expect(described_class.pragma_format).to match("#frozen_string_literal:true")
    end

    it "matches comment with numbers" do
      expect(described_class.pragma_format).to match("# encoding: 1234")
    end

    it "matches comment with dashes" do
      expect(described_class.pragma_format).to match("# encoding: ISO-8859-1")
    end

    it "matches comment with underscores" do
      expect(described_class.pragma_format).to match("# encoding: ASCII_8BIT")
    end

    it "does not match shebangs" do
      expect(described_class.pragma_format).to_not match("#!/usr/bin/ruby")
    end

    it "does not match normal comments" do
      expect(described_class.pragma_format).to_not match("# This is a normal comment.")
    end
  end

  describe "#format_shebang" do
    subject { described_class.new comment }

    context "with formatted shebang" do
      let(:comment) { "#! /usr/bin/ruby" }

      it "answers formatted shebang" do
        expect(subject.format_shebang).to eq("#! /usr/bin/ruby")
      end
    end

    context "with unformatted shebang" do
      let(:comment) { "#!/usr/bin/ruby" }

      it "answers formatted shebang" do
        expect(subject.format_shebang).to eq("#! /usr/bin/ruby")
      end
    end

    context "with comment that doesn't look like a shebang" do
      let(:comment) { "# Test." }

      it "answers original comment" do
        expect(subject.format_shebang).to eq("# Test.")
      end
    end
  end

  describe "#format_pragma" do
    subject { described_class.new comment }

    context "with formatted pragma" do
      let(:comment) { "# frozen_string_literal: true" }

      it "answers formatted pragma" do
        expect(subject.format_pragma).to eq("# frozen_string_literal: true")
      end
    end

    context "with unformatted pragma" do
      let(:comment) { "#frozen_string_literal:true" }

      it "answers formatted pragma" do
        expect(subject.format_pragma).to eq("# frozen_string_literal: true")
      end
    end

    context "with comment that doesn't look like a pragma" do
      let(:comment) { "# Test." }

      it "answers original comment" do
        expect(subject.format_pragma).to eq("# Test.")
      end
    end
  end

  describe "#format" do
    subject { described_class.new comment }

    context "when shebang" do
      let(:comment) { "#! /usr/bin/ruby" }

      it "answers shebang" do
        expect(subject.format).to eq("#! /usr/bin/ruby")
      end
    end

    context "when pragma" do
      let(:comment) { "# frozen_string_literal: true" }

      it "answers pragma" do
        expect(subject.format).to eq("# frozen_string_literal: true")
      end
    end

    context "when other" do
      let(:comment) { "# Some random comment." }

      it "answers pragma" do
        expect(subject.format).to eq("# Some random comment.")
      end
    end
  end
end
