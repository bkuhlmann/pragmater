# frozen_string_literal: true

require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores pragma comments.
      class Comment < Sod::Action
        include Import[:input]

        description "Set pragma comments."

        on %w[-c --comments], argument: "[a,b,c]"

        default { Container[:configuration].patterns }

        def call(comments = nil) = input.comments = Array(comments || default)
      end
    end
  end
end
