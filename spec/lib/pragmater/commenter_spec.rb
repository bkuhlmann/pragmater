require "spec_helper"

describe Pragmater::Commenter do
  let(:older) { [] }
  let(:newer) { [] }
  subject { described_class.new older, newer }

  describe "#add" do
    context "with a single new comment" do
      let(:newer) { "# frozen_string_literal: true" }

      it "answers array of added comments" do
        expect(subject.add).to contain_exactly("# frozen_string_literal: true")
      end
    end

    context "with multiple new comments" do
      let(:newer) { ["# encoding: UTF-8", "# frozen_string_literal: true"] }

      it "answers array of added comments" do
        expect(subject.add).to contain_exactly("# encoding: UTF-8", "# frozen_string_literal: true")
      end
    end

    context "with a single old comment" do
      let(:older) { "# encoding: UTF-8" }

      it "answers array of added comments" do
        expect(subject.add).to contain_exactly("# encoding: UTF-8")
      end
    end

    context "with multiple old comments" do
      let(:older) { ["# encoding: UTF-8", "# frozen_string_literal: true"] }

      it "answers array of added comments" do
        expect(subject.add).to contain_exactly("# encoding: UTF-8", "# frozen_string_literal: true")
      end
    end

    context "with multiple old and new comments" do
      let(:older) { ["# frozen_string_literal: true", "# example: test"] }
      let(:newer) { ["# encoding: UTF-8", "# coding: UTF-8"] }

      it "answers array of added comments" do
        expect(subject.add).to contain_exactly(
          "# frozen_string_literal: true",
          "# example: test",
          "# encoding: UTF-8",
          "# coding: UTF-8"
        )
      end
    end

    context "with duplicate comments" do
      let(:older) { "# encoding: UTF-8" }
      let(:newer) { ["# frozen_string_literal: true", "# encoding: UTF-8"] }

      it "answers array of non-duplicated comments" do
        expect(subject.add).to contain_exactly("# encoding: UTF-8", "# frozen_string_literal: true")
      end
    end

    context "with empty old and new comments" do
      it "answers empty array" do
        expect(subject.add).to be_empty
      end
    end
  end

  describe "#remove" do
    context "with older and newer comments that match" do
      let(:older) { ["# frozen_string_literal: true", "# encoding: UTF-8", "# coding: UTF-8"] }
      let(:newer) { ["# coding: UTF-8", "# encoding: UTF-8"] }

      it "answers array with matches from older and newer comments removed" do
        expect(subject.remove).to contain_exactly("# frozen_string_literal: true")
      end
    end

    context "with older and newer comments that don't match" do
      let(:older) { "# encoding: UTF-8" }
      let(:newer) { ["# frozen_string_literal: true", "# coding: UTF-8"] }

      it "answers array of older comments only" do
        expect(subject.remove).to contain_exactly("# encoding: UTF-8")
      end
    end

    context "with empty older comments and array of newer comments" do
      let(:newer) { "# encoding: UTF-8" }

      it "answers empty array" do
        expect(subject.remove).to be_empty
      end
    end

    context "with empty older and newer comments" do
      it "answers empty array" do
        expect(subject.remove).to be_empty
      end
    end
  end
end
