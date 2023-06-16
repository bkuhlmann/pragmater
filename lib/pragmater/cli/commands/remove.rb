# frozen_string_literal: true

require "sod"

module Pragmater
  module CLI
    module Commands
      # Removes pragmas.
      class Remove < Sod::Command
        include Import[:input, :kernel]

        handle "remove"

        description "Remove pragma comments."

        on Actions::Root
        on Actions::Comment
        on Actions::Pattern

        def initialize(handler: Remover.new, **)
          super(**)
          @handler = handler
        end

        def call = handler.call(input) { |path| kernel.puts path }

        private

        attr_reader :handler
      end
    end
  end
end
