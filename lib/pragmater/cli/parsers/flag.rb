# frozen_string_literal: true

require "core"
require "refinements/structs"

module Pragmater
  module CLI
    module Parsers
      # Parses common command line flags.
      class Flag
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize configuration = Container[:configuration], client: Parser::CLIENT
          @configuration = configuration
          @client = client
        end

        def call arguments = ::Core::EMPTY_ARRAY
          client.separator "\nOPTIONS:\n"
          collate
          client.parse arguments
          configuration
        end

        private

        attr_reader :configuration, :client

        def collate = private_methods.sort.grep(/add_/).each { |method| __send__ method }

        def add_comments
          client.on "--comments a,b,c", Array, "Add pragma comments. Default: []." do |comments|
            configuration.merge! comments:
          end
        end

        def add_includes
          client.on "--includes a,b,c", Array, "Add include patterns. Default: []." do |includes|
            configuration.merge! includes:
          end
        end
      end
    end
  end
end
