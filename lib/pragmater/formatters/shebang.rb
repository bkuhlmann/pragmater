# frozen_string_literal: true

module Pragmater
  module Formatters
    # Formats shebang pragmas in a consistent manner.
    class Shebang
      PATTERN = %r(\A\#!\s?/.*ruby\Z)

      def initialize string, pattern: PATTERN
        @string = string
        @pattern = pattern
      end

      def call
        return string unless string.match? pattern

        string.split("!").then { |octothorpe, path| "#{octothorpe}! #{path.strip}" }
      end

      private

      attr_reader :string, :pattern
    end
  end
end
