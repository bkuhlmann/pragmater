# frozen_string_literal: true

require "optparse"
require "forwardable"

module Pragmater
  module CLI
    module Options
      # Coalesces all options and arguments into a single hash for further processing.
      class Assembler
        extend Forwardable

        PARSER = OptionParser.new nil, 40, "  "
        SECTIONS = [Core, InsertRemove, Configuration].freeze

        EXCEPTIONS = [
          OptionParser::InvalidOption,
          OptionParser::MissingArgument,
          OptionParser::InvalidArgument
        ].freeze

        delegate %i[to_s] => :parser

        def initialize sections: SECTIONS, parser: PARSER, exceptions: EXCEPTIONS
          @sections = sections
          @parser = parser
          @options = {}
          @exceptions = exceptions
        end

        def call arguments = []
          sections.each { |section| section.new(options, parser:).call }
          parser.parse! arguments
          options
        rescue *EXCEPTIONS
          {}
        end

        private

        attr_reader :parser, :sections, :options, :exceptions
      end
    end
  end
end
