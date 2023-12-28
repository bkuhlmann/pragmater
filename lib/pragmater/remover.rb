# frozen_string_literal: true

require "refinements/pathname"

module Pragmater
  # Removes pragma comments.
  class Remover
    using Refinements::Pathname

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
