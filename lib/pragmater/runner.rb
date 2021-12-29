# frozen_string_literal: true

require "refinements/pathnames"

module Pragmater
  # Adds/removes pragma comments for files in given path.
  class Runner
    using Refinements::Pathnames

    def initialize parser: Parsers::File.new, container: Container
      @parser = parser
      @container = container
    end

    def call configuration = Configuration::Loader.call
      Pathname(configuration.root_dir).files("{#{configuration.includes.join ","}}").map do |path|
        yield path if block_given?

        case configuration
          in action_insert: true then write path, configuration, :insert
          in action_remove: true then write path, configuration, :remove
          else logger.error { "Unknown run action. Use insert or remove." }
        end
      end
    end

    private

    attr_reader :parser, :container

    def write path, configuration, action
      path.write parser.call(path, configuration.comments, action:).join
    end

    def logger = container[__method__]
  end
end
