# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::Remover do
  using Refinements::Pathname
  using Refinements::Struct

  subject(:remover) { described_class.new }

  include_context "with application dependencies"

  describe "#call" do
    let :test_files do
      [
        temp_dir.join("test.rb"),
        temp_dir.join("task", "test.rake"),
        temp_dir.join("test.txt")
      ]
    end

    let :test_configuration do
      configuration.merge! patterns: ["*.rb"], comments: ["# encoding: UTF-8"]
    end

    before { test_files.each { |path| path.make_ancestors.touch } }

    it "yields when given a block" do
      kernel = class_spy Kernel
      remover.call(test_configuration) { |path| kernel.print path }

      expect(kernel).to have_received(:print).with(temp_dir.join("test.rb"))
    end

    it "answers processed files" do
      expect(remover.call(test_configuration)).to contain_exactly(temp_dir.join("test.rb"))
    end

    it "modify files with matching extensions" do
      temp_dir.join("test.rb").rewrite { |body| "# encoding: UTF-8\n#{body}" }
      remover.call test_configuration

      expect(test_files.map(&:read)).to contain_exactly("", "", "")
    end
  end
end
