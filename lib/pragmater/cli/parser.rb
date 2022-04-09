# frozen_string_literal: true

require "optparse"

module Pragmater
  module CLI
    # Assembles and parses all Command Line Interface (CLI) options.
    class Parser
      include Import[:configuration]

      CLIENT = OptionParser.new nil, 40, "  "
      SECTIONS = [Parsers::Core, Parsers::Flag].freeze # Order matters.

      def initialize sections: SECTIONS, client: CLIENT, **dependencies
        super(**dependencies)
        @sections = sections
        @client = client
        @configuration_duplicate = configuration.dup
      end

      def call arguments = []
        sections.each { |section| section.call configuration_duplicate, client: }
        client.parse arguments
        configuration_duplicate.freeze
      end

      def to_s = client.to_s

      private

      attr_reader :sections, :client, :configuration_duplicate
    end
  end
end
