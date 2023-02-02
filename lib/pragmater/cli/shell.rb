# frozen_string_literal: true

require "core"

module Pragmater
  module CLI
    # The main Command Line Interface (CLI) object.
    class Shell
      include Actions::Import[:config, :run, :specification, :logger]

      def initialize(parser: Parser.new, **)
        super(**)
        @parser = parser
      end

      def call arguments = Core::EMPTY_ARRAY
        act_on parser.call(arguments)
      rescue OptionParser::ParseError => error
        logger.error { error.message }
      end

      private

      attr_reader :parser

      def act_on configuration
        case configuration
          in action_config: Symbol => action then config.call action
          in {action_insert: true} | {action_remove: true} then run.call configuration
          in action_version: true then logger.info { specification.labeled_version }
          else logger.any { parser.to_s }
        end
      end
    end
  end
end
