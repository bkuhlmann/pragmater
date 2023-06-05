# frozen_string_literal: true

require "refinements/pathnames"

module Pragmater
  # Inserts pragma comments.
  class Inserter
    using Refinements::Pathnames

    def initialize parser: Parsers::File.new
      @parser = parser
    end

    def call configuration = Container[:configuration]
      Pathname(configuration.root_dir).files("{#{configuration.patterns.join ","}}").map do |path|
        yield path if block_given?
        path.write parser.call(path, configuration.comments, action: :insert).join
      end
    end

    private

    attr_reader :parser
  end
end
