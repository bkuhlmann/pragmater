# frozen_string_literal: true

module Pragmater
  # Adds/removes pragma comments for files in given path.
  class Runner
    # rubocop:disable Metrics/ParameterLists
    def initialize path = ".", comments: [], includes: [], writer: Writer
      @path = Pathname path
      @comments = Array comments
      @includes = Array includes
      @writer = writer
    end
    # rubocop:enable Metrics/ParameterLists

    def files
      return [] unless path.exist? && path.directory? && !includes.empty?

      Pathname.glob(%(#{path}/{#{includes.join ","}})).select(&:file?)
    end

    def run action:
      files.each do |file|
        writer.new(file, comments).public_send action
        yield file if block_given?
      end
    end

    private

    attr_reader :path, :comments, :includes, :writer
  end
end
