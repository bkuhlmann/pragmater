# frozen_string_literal: true

module Pragmater
  module CLI
    module Options
      # Defines gem insert and remove options.
      class InsertRemove
        def initialize values, parser: OptionParser.new
          @values = values
          @parser = parser
        end

        def call
          parser.separator "\nOPTIONS:\n"
          parser.separator "\nInsert/Remove:\n"
          private_methods.grep(/add_/).each(&method(:__send__))
          parser
        end

        private

        attr_reader :values, :parser

        def add_comments
          parser.on "--comments a,b,c", Array, "Add pragma comments." do |comments|
            values[:comments] = comments
          end
        end

        def add_includes
          parser.on "--includes a,b,c", Array, "Add console support." do |includes|
            values[:includes] = includes
          end
        end
      end
    end
  end
end
