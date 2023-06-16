# frozen_string_literal: true

require "refinements/structs"
require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores pragma comments.
      class Comment < Sod::Action
        include Import[:input]

        using Refinements::Structs

        description "Set pragma comments."

        on %w[-c --comments], argument: "[a,b,c]"

        default { Container[:configuration].patterns }

        def call(comments = default) = input.merge! comments: Array(comments)
      end
    end
  end
end
