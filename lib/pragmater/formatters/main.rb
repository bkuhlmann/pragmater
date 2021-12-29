# frozen_string_literal: true

module Pragmater
  module Formatters
    # Formats all pragmas in a consistent manner.
    class Main
      FORMATTERS = [General, Shebang].freeze
      PATTERN = FORMATTERS.map { |formatter| formatter::PATTERN }
                          .then { |patterns| Regexp.union(*patterns) }
                          .freeze

      def initialize string, formatters: FORMATTERS
        @string = string
        @formatters = formatters
      end

      def call = formatters.reduce(string) { |pragma, formatter| formatter.new(pragma).call }

      private

      attr_reader :string, :formatters
    end
  end
end
