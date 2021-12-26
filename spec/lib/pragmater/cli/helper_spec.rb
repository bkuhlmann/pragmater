# frozen_string_literal: true

require "spec_helper"

RSpec.describe Pragmater::CLI::Helper do
  subject(:helper) { described_class.new commander:, logger: }

  let(:commander) { class_spy Open3 }
  let(:logger) { instance_spy Logger }

  describe "#run" do
    it "runs command" do
      command = %(echo "Test.")
      helper.run command
      expect(commander).to have_received(:capture3).with(command)
    end
  end

  describe "#info" do
    it "logs info" do
      helper.info "Test."
      expect(logger).to have_received(:info).with("Test.")
    end
  end

  describe "#warn" do
    it "logs warning" do
      helper.warn "Test."
      expect(logger).to have_received(:warn).with("Test.")
    end
  end

  describe "#error" do
    it "logs error" do
      helper.error "Test."
      expect(logger).to have_received(:error).with("Test.")
    end
  end

  describe "#fatal" do
    it "logs fatal" do
      helper.fatal "Test."
      expect(logger).to have_received(:fatal).with("Test.")
    end
  end

  describe "#debug" do
    it "logs debug" do
      helper.debug "Test."
      expect(logger).to have_received(:debug).with("Test.")
    end
  end

  describe "#unknown" do
    it "logs unknown" do
      helper.unknown "Test."
      expect(logger).to have_received(:unknown).with("Test.")
    end
  end
end
