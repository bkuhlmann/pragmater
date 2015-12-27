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

    def format comments
      Array(comments).map { |comment| formatter.new(comment).format }
    end
  end
end
