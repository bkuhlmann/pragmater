# frozen_string_literal: true

require "refinements/structs"
require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores file patterns.
      class Pattern < Sod::Action
        include Import[:inputs]

        using Refinements::Structs

        description "Set file patterns."

        on %w[-p --patterns], argument: "[a,b,c]"

        default { Container[:configuration].patterns }

        def call(patterns = default) = inputs.merge! patterns: Array(patterns)
      end
    end
  end
end
