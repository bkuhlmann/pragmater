# frozen_string_literal: true

module Pragmater
  module CLI
    module Options
      # Defines gem configuration options.
      class Configuration
        def initialize values, parser: OptionParser.new
          @parser = parser
          @values = values
        end

        def call
          parser.separator "\nConfiguration:\n"
          private_methods.grep(/add_/).each(&method(:__send__))
          parser
        end

        private

        attr_reader :parser, :values

        def add_edit
          parser.on "--edit", "Edit configuration." do
            values[:edit] = true
          end
        end

        def add_info
          parser.on "--info", "Print configuration." do
            values[:info] = true
          end
        end
      end
    end
  end
end
