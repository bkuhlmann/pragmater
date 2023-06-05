# frozen_string_literal: true

require "refinements/structs"
require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores root path.
      class Root < Sod::Action
        include Import[:inputs]

        using Refinements::Structs

        description "Set root directory."

        on %w[-r --root], argument: "[PATH]"

        default { Container[:configuration].root_dir }

        def call(path = default) = inputs.merge! root_dir: Pathname(path)
      end
    end
  end
end
