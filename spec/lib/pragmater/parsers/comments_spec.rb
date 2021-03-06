# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Parsers::Comments do
  subject(:commenter) { described_class.new older, newer }

  let(:older) { [] }
  let(:newer) { [] }

  describe "#insert" do
    context "with single newer comment" do
      let(:newer) { "# frozen_string_literal: true" }

      it "answers array of added comments" do
        expect(commenter.insert).to contain_exactly("# frozen_string_literal: true")
      end
    end

    context "with multiple newer comments" do
      let(:newer) { ["# encoding: UTF-8", "# frozen_string_literal: true"] }

      it "answers array of added comments" do
        expect(commenter.insert).to contain_exactly(
          "# encoding: UTF-8",
          "# frozen_string_literal: true"
        )
      end
    end

    context "with single older comment" do
      let(:older) { "# encoding: UTF-8" }

      it "answers array of added comments" do
        expect(commenter.insert).to contain_exactly("# encoding: UTF-8")
      end
    end

    context "with multiple older comments" do
      let(:older) { ["# encoding: UTF-8", "# frozen_string_literal: true"] }

      it "answers array of added comments" do
        expect(commenter.insert).to contain_exactly(
          "# encoding: UTF-8",
          "# frozen_string_literal: true"
        )
      end
    end

    context "with multiple older and newer comments" do
      let(:older) { ["# frozen_string_literal: true", "# example: test"] }
      let(:newer) { ["# encoding: UTF-8", "# coding: UTF-8"] }

      it "answers array of added comments" do
        expect(commenter.insert).to contain_exactly(
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
        expect(commenter.insert).to contain_exactly(
          "# encoding: UTF-8",
          "# frozen_string_literal: true"
        )
      end
    end

    context "with newer comment only" do
      let(:newer) { "# bogus" }

      it "answers array with original comment" do
        expect(commenter.insert).to contain_exactly("# bogus")
      end
    end

    context "with empty older and newer comments" do
      it "answers empty array" do
        expect(commenter.insert).to be_empty
      end
    end
  end

  describe "#remove" do
    context "with older and newer comments that match" do
      let(:older) { ["# frozen_string_literal: true", "# encoding: UTF-8", "# coding: UTF-8"] }
      let(:newer) { ["# coding: UTF-8", "# encoding: UTF-8"] }

      it "answers array with matches from older and newer comments removed" do
        expect(commenter.remove).to contain_exactly("# frozen_string_literal: true")
      end
    end

    context "with older and newer comments that don't match" do
      let(:older) { "# encoding: UTF-8" }
      let(:newer) { ["# frozen_string_literal: true", "# coding: UTF-8"] }

      it "answers array of older comments only" do
        expect(commenter.remove).to contain_exactly("# encoding: UTF-8")
      end
    end

    context "with empty older comments and array of newer comments" do
      let(:newer) { "# encoding: UTF-8" }

      it "answers empty array" do
        expect(commenter.remove).to be_empty
      end
    end

    context "with newer, invalid, comments" do
      let(:older) { "# bogus" }
      let(:newer) { "# bogus" }

      it "answers empty array" do
        expect(commenter.remove).to be_empty
      end
    end

    context "with empty older and newer comments" do
      it "answers empty array" do
        expect(commenter.remove).to be_empty
      end
    end
  end
end
