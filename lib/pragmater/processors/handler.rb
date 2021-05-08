# frozen_string_literal: true

module Pragmater
  module Processors
    # Handles the insertion or removal of pragma comments.
    class Handler
      DEFAULTS = {insert: Inserter, remove: Remover}.freeze

      def initialize processors: DEFAULTS
        @processors = processors
      end

      def call action, comments, body
        processors.fetch(action).new(comments, body).call
      end

      private

      attr_reader :processors
    end
  end
end
