# frozen_string_literal: true

module Pragmater
  module CLI
    module Actions
      # Handles insert or remove actions.
      class Run
        def initialize runner: Runner.new, container: Container
          @runner = runner
          @container = container
        end

        def call(configuration) = runner.call(configuration) { |path| logger.info { path } }

        private

        attr_reader :runner, :container

        def logger = container[__method__]
      end
    end
  end
end
