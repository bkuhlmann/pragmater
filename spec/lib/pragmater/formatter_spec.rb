# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Formatter do
  describe ".shebang_format" do
    it "matches formatted comment" do
      expect(described_class.shebang_format).to match("#! /usr/bin/env ruby")
    end

    it "matches unformatted comment" do
      expect(described_class.shebang_format).to match("#!/usr/bin/env ruby")
    end

    it "matches minimal path" do
      expect(described_class.shebang_format).to match("#!/ruby")
    end

    it "does not match when space exists between comment and bang symbol" do
      expect(described_class.shebang_format).to_not match("# ! /usr/bin/env ruby")
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

    it "matches with numbers" do
      expect(described_class.pragma_format).to match("# encoding: 1234")
    end

    it "matches with dashes" do
      expect(described_class.pragma_format).to match("# encoding: ISO-8859-1")
    end

    it "matches with underscores" do
      expect(described_class.pragma_format).to match("# encoding: ASCII_8BIT")
    end

    it "does not match shebangs" do
      expect(described_class.pragma_format).to_not match("#!/usr/bin/ruby")
    end

    it "does not match normal comments" do
      expect(described_class.pragma_format).to_not match("# This is a normal comment.")
    end
  end

  describe ".valid_formats" do
    it "match shebang format" do
      expect(described_class.valid_formats).to match("#! /usr/bin/env ruby")
    end

    it "match frozen string literal format" do
      expect(described_class.valid_formats).to match("# frozen_string_literal: true")
    end

    it "does not match general comments" do
      expect(described_class.valid_formats).to_not match("# A example comment.")
    end
  end

  describe "#format_shebang" do
    subject { described_class.new string }

    context "with formatted shebang" do
      let(:string) { "#! /usr/bin/env ruby" }

      it "answers formatted shebang" do
        expect(subject.format_shebang).to eq("#! /usr/bin/env ruby")
      end
    end

    context "with unformatted shebang" do
      let(:string) { "#!/usr/bin/env ruby" }

      it "answers formatted shebang" do
        expect(subject.format_shebang).to eq("#! /usr/bin/env ruby")
      end
    end

    context "with string that doesn't look like a shebang" do
      let(:string) { "# Test." }

      it "answers original string" do
        expect(subject.format_shebang).to eq("# Test.")
      end
    end
  end

  describe "#format_pragma" do
    subject { described_class.new string }

    context "with formatted pragma" do
      let(:string) { "# frozen_string_literal: true" }

      it "answers formatted pragma" do
        expect(subject.format_pragma).to eq("# frozen_string_literal: true")
      end
    end

    context "with unformatted pragma" do
      let(:string) { "#frozen_string_literal:true" }

      it "answers formatted pragma" do
        expect(subject.format_pragma).to eq("# frozen_string_literal: true")
      end
    end

    context "with string that doesn't look like a pragma" do
      let(:string) { "# Test." }

      it "answers original string" do
        expect(subject.format_pragma).to eq("# Test.")
      end
    end
  end

  describe "#format" do
    subject { described_class.new string }

    context "when shebang" do
      let(:string) { "#! /usr/bin/env ruby" }

      it "answers shebang" do
        expect(subject.format).to eq("#! /usr/bin/env ruby")
      end
    end

    context "when pragma" do
      let(:string) { "# frozen_string_literal: true" }

      it "answers pragma" do
        expect(subject.format).to eq("# frozen_string_literal: true")
      end
    end

    context "when normal comment" do
      let(:string) { "# Some random comment." }

      it "answers normal comment" do
        expect(subject.format).to eq("# Some random comment.")
      end
    end
  end
end
