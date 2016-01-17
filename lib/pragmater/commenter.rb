# frozen_string_literal: true

module Pragmater
  # Handles pragma comments.
  class Commenter
    def initialize older, newer, formatter: Formatter
      @formatter = formatter
      @older = format older
      @newer = format newer
    end

    def add
      older | newer
    end

    def remove
      older - (older & newer)
    end

    private

    attr_reader :older, :newer, :formatter

    def filter comments
      Array(comments).select { |comment| comment =~ formatter.valid_formats }
    end

    def format comments
      filter(comments).map { |comment| formatter.new(comment).format }
    end
  end
end
