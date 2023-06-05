# frozen_string_literal: true

require "refinements/pathnames"

module Pragmater
  # Removes pragma comments.
  class Remover
    using Refinements::Pathnames

    def initialize parser: Parsers::File.new
      @parser = parser
    end

    def call configuration = Container[:configuration]
      Pathname(configuration.root_dir).files("{#{configuration.patterns.join ","}}").map do |path|
        yield path if block_given?
        path.write parser.call(path, configuration.comments, action: :remove).join
      end
    end

    private

    attr_reader :parser
  end
end
