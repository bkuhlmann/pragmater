# frozen_string_literal: true

module Pragmater
  module CLI
    module Options
      # Defines gem primary options.
      class Core
        def initialize values, parser: OptionParser.new
          @values = values
          @parser = parser
        end

        def call
          parser.banner = "#{Identity::LABEL} - #{Identity::SUMMARY}"
          parser.separator "\nUSAGE:\n"
          private_methods.grep(/add_/).each { |method| __send__ method }
          parser
        end

        private

        attr_reader :values, :parser

        def add_configuration
          parser.on "-c", "--config [options]", "Manage gem configuration." do
            values[:config] = true
          end
        end

        def add_insert
          parser.on "-i", "--insert [PATH]", "Insert pragam comments into files." do |path|
            values[:insert] = path || "."
          end
        end

        def add_remove
          parser.on "-r", "--remove [options]", "Remove pragam comments from files." do |path|
            values[:remove] = path || "."
          end
        end

        def add_version
          parser.on "-v", "--version", "Show gem version." do
            values[:version] = Identity::VERSION
          end
        end

        def add_help
          parser.on "-h", "--help", "Show this message." do
            values[:help] = true
          end
        end
      end
    end
  end
end
