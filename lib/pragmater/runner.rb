# frozen_string_literal: true

module Pragmater
  # Adds/removes pragma comments for files in given path.
  class Runner
    # rubocop:disable Metrics/ParameterLists
    def initialize path = ".", comments: [], whitelist: [], writer: Writer
      @path = Pathname path
      @comments = Array comments
      @whitelist = Array whitelist
      @writer = writer
    end

    def files
      return [] unless path.exist? && path.directory? && !whitelist.empty?
      Pathname.glob(%(#{path}/{#{whitelist.join ","}})).select(&:file?)
    end

    def run action:
      files.each do |file|
        writer.new(file, comments).public_send action
        yield file if block_given?
      end
    end

    private

    attr_reader :path, :comments, :whitelist, :writer
  end
end
