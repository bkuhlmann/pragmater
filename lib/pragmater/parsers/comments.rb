# frozen_string_literal: true

module Pragmater
  module Parsers
    # Manages pragma comments.
    class Comments
      def initialize older, newer, formatter: Formatters::Main
        @formatter = formatter
        @older = format older
        @newer = format newer
      end

      def insert = older.union(newer)

      def remove = older - older.intersection(newer)

      private

      attr_reader :formatter, :older, :newer

      def format(pragmas) = Array(pragmas).map { |pragma| formatter.new(pragma).call }
    end
  end
end
