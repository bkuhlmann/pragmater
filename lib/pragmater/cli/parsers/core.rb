# frozen_string_literal: true

require "refinements/structs"

module Pragmater
  module CLI
    module Parsers
      # Handles parsing of Command Line Interface (CLI) core options.
      class Core
        using Refinements::Structs

        def self.call(...) = new(...).call

        def initialize configuration = Container[:configuration],
                       client: Parser::CLIENT,
                       container: Container
          @configuration = configuration
          @client = client
          @container = container
        end

        def call arguments = []
          client.banner = "Pragmater - #{specification.summary}"
          client.separator "\nUSAGE:\n"
          collate
          client.parse arguments
          configuration
        end

        private

        attr_reader :configuration, :client, :container

        def collate = private_methods.sort.grep(/add_/).each { |method| __send__ method }

        def add_config
          client.on "-c",
                    "--config ACTION",
                    %i[edit view],
                    "Manage gem configuration: edit or view." do |action|
            configuration.merge! action_config: action
          end
        end

        def add_insert
          client.on "-i", "--insert [PATH]", %(Insert pragmas. Default: "#{root_dir}".) do |path|
            configuration.merge! action_insert: true, root_dir: path || root_dir
          end
        end

        def add_remove
          client.on "-r", "--remove [PATH]", %(Remove pragmas. Default: "#{root_dir}".) do |path|
            configuration.merge! action_remove: true, root_dir: path || root_dir
          end
        end

        def add_version
          client.on "-v", "--version", "Show gem version." do
            configuration.merge! action_version: true
          end
        end

        def add_help
          client.on "-h", "--help", "Show this message." do
            configuration.merge! action_help: true
          end
        end

        def root_dir = configuration.root_dir

        def specification = container[__method__]
      end
    end
  end
end
