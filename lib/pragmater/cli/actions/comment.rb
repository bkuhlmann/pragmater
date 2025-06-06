# frozen_string_literal: true

require "sod"

module Pragmater
  module CLI
    module Actions
      # Stores pragma comments.
      class Comment < Sod::Action
        include Dependencies[:settings]

        description "Set pragma comments."

        on %w[-c --comments], argument: "[a,b,c]"

        default { Container[:settings].comments }

        def call(comments = default) = settings.comments = Array(comments)
      end
    end
  end
end
