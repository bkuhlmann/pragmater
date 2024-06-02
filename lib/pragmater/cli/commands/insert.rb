# frozen_string_literal: true

require "sod"

module Pragmater
  module CLI
    module Commands
      # Inserts pragmas.
      class Insert < Sod::Command
        include Import[:settings, :kernel]

        handle "insert"

        description "Insert pragma comments."

        on Actions::Root
        on Actions::Comment
        on Actions::Pattern

        def initialize(handler: Inserter.new, **)
          super(**)
          @handler = handler
        end

        def call = handler.call { |path| kernel.puts path }

        private

        attr_reader :handler
      end
    end
  end
end
