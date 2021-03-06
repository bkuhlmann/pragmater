# frozen_string_literal: true

require "refinements/pathnames"

module Pragmater
  # Adds/removes pragma comments for files in given path.
  class Runner
    using Refinements::Pathnames

    def self.for **attributes
      new Context[attributes]
    end

    def initialize context, parser: Parsers::File.new
      @context = context
      @parser = parser
    end

    def call
      Pathname(context.root_dir).files("{#{context.includes.join ","}}").map do |path|
        path.write parser.call(path, context.comments, action: context.action).join
      end
    end

    private

    attr_reader :context, :parser
  end
end
