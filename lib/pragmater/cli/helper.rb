# frozen_string_literal: true

require "forwardable"
require "open3"
require "logger"

module Pragmater
  module CLI
    # A simple delegator for common shell functionality.
    class Helper
      extend Forwardable

      LOGGER = Logger.new STDOUT,
                          formatter: (
                            proc do |_severity, _datetime, _program_name, message|
                              "#{message}\n"
                            end
                          )

      delegate %i[info error fatal debug unknown] => :logger

      def initialize commander: Open3, logger: LOGGER
        @commander = commander
        @logger = logger
      end

      def run command
        commander.capture3 command
      end

      def warn message
        logger.warn message
      end

      private

      attr_reader :commander, :logger
    end
  end
end
