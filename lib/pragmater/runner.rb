# frozen_string_literal: true

require "refinements/pathnames"

module Pragmater
  # Adds/removes pragma comments for files in given path.
  class Runner
    include Import[:logger]

    using Refinements::Pathnames

    def initialize parser: Parsers::File.new, **dependencies
      super(**dependencies)
      @parser = parser
    end

    def call configuration = Container[:configuration]
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

    attr_reader :parser

    def write path, configuration, action
      path.write parser.call(path, configuration.comments, action:).join
    end
  end
end
