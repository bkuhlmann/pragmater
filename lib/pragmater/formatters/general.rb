# frozen_string_literal: true

module Pragmater
  module Formatters
    # Formats general pragmas in a consistent manner.
    class General
      PATTERN = /
        \A      # Start of line.
        \#      # Start of comment.
        \s?     # Space - optional.
        \w+     # Key - One or more word characters only.
        :       # Delimiter.
        \s?     # Space - optional.
        [\w-]+  # Value - One or more word or dash characters.
        \Z      # End of line.
      /x

      def initialize string, pattern: PATTERN
        @string = string
        @pattern = pattern
      end

      def call
        return string unless string.match? pattern

        string.split(":").then { |key, value| "# #{key.gsub(/\#\s?/, "")}: #{value.strip}" }
      end

      private

      attr_reader :string, :pattern
    end
  end
end
