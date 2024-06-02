# frozen_string_literal: true

require "refinements/pathname"

module Pragmater
  # Removes pragma comments.
  class Remover
    include Import[:settings]

    using Refinements::Pathname

    def initialize(parser: Parsers::File.new, **)
      @parser = parser
      super(**)
    end

    def call
      Pathname(settings.root_dir).files("{#{settings.patterns.join ","}}").map do |path|
        yield path if block_given?
        path.write parser.call(path, settings.comments, action: :remove).join
      end
    end

    private

    attr_reader :parser
  end
end
