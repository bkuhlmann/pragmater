# frozen_string_literal: true

require "optparse"

module Pragmater
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      CLIENT = OptionParser.new nil, 40, "  "
      SECTIONS = [Parsers::Core, Parsers::Flag].freeze # Order is important.

      def initialize sections: SECTIONS, client: CLIENT, container: Container
        @sections = sections
        @client = client
        @configuration = container[:configuration].dup
      end

      def call arguments = []
        sections.each { |section| section.call configuration, client: }
        client.parse arguments
        configuration.freeze
      end

      def to_s = client.to_s

      private

      attr_reader :sections, :client, :configuration
    end
  end
end
