# frozen_string_literal: true

require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores root path.
      class Root < Sod::Action
        include Import[:settings]

        description "Set root directory."

        on %w[-r --root], argument: "[PATH]"

        default { Container[:settings].root_dir }

        def call(path = nil) = settings.root_dir = Pathname(path || default)
      end
    end
  end
end
