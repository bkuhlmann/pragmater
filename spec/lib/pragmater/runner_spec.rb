# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Runner, :temp_dir do
  let(:path) { "." }
  let(:comments) { [] }
  let(:whitelist) { [] }

  describe "#files" do
    let(:tasks_dir) { File.join temp_dir, "tasks" }
    let(:ruby_file) { File.join temp_dir, "test.rb" }
    let(:rake_file) { File.join tasks_dir, "test.rake" }
    let(:text_file) { File.join temp_dir, "test.txt" }
    subject { described_class.new path, comments: comments, whitelist: whitelist }

    before do
      FileUtils.mkdir tasks_dir
      FileUtils.touch [ruby_file, rake_file, text_file]
    end

    context "with defaults" do
      subject { described_class.new }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path only" do
      let(:path) { temp_dir }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with whitelist only" do
      let(:whitelist) { ["*.rb"] }

      it "answers files with matching extensions" do
        Dir.chdir temp_dir do
          expect(subject.files).to contain_exactly(Pathname("./test.rb"))
        end
      end
    end

    context "with path and whitelist string" do
      let(:path) { temp_dir }
      let(:whitelist) { "*.rb" }

      it "answers files with matching extensions" do
        expect(subject.files).to contain_exactly(Pathname("#{temp_dir}/test.rb"))
      end
    end

    context "with path and whitelist array" do
      let(:path) { temp_dir }
      let(:whitelist) { ["*.rb"] }

      it "answers files with matching extensions" do
        expect(subject.files).to contain_exactly(Pathname("#{temp_dir}/test.rb"))
      end
    end

    context "with invalid path" do
      let(:path) { "bogus" }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path and invalid whitelist" do
      let(:path) { temp_dir }
      let(:whitelist) { ["bogus", "~#}*^"] }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path and whitelist without wildcards" do
      let(:path) { temp_dir }
      let(:whitelist) { [".rb"] }

      it "answers empty array" do
        expect(subject.files).to be_empty
      end
    end

    context "with path and recursive whitelist" do
      let(:path) { temp_dir }
      let(:whitelist) { ["**/*.rake"] }
      let(:nested_file) { Pathname File.join(tasks_dir, "nested", "nested.rake") }

      before do
        FileUtils.mkdir File.join(tasks_dir, "nested")
        FileUtils.touch nested_file
      end

      it "answers recursed files" do
        expect(subject.files).to contain_exactly(
          nested_file,
          Pathname("#{tasks_dir}/test.rake")
        )
      end
    end
  end

  describe "#run" do
    let(:writer_class) { class_spy Pragmater::Writer }
    let(:writer_instance) { instance_spy Pragmater::Writer }
    subject { described_class.new temp_dir, whitelist: whitelist, writer: writer_class }

    context "without files" do
      let(:action) { :add }

      it "doesn't update files" do
        subject.run action: action
        expect(writer_instance).to_not have_received(action)
      end
    end

    context "with files" do
      let(:whitelist) { ["*.rb"] }
      let(:action) { :remove }
      let(:test_file) { Pathname "#{temp_dir}/test.rb" }

      before do
        FileUtils.touch test_file
        allow(writer_class).to receive(:new).with(test_file, comments).and_return(writer_instance)
      end

      it "updates files" do
        subject.run action: action
        expect(writer_instance).to have_received(action)
      end
    end
  end
end
