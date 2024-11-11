# frozen_string_literal: true

require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores file patterns.
      class Pattern < Sod::Action
        include Dependencies[:settings]

        description "Set file patterns."

        on %w[-p --patterns], argument: "[a,b,c]"

        default { Container[:settings].patterns }

        def call(patterns = default) = settings.patterns = Array(patterns)
      end
    end
  end
end
