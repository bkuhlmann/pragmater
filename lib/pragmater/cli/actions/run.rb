# frozen_string_literal: true

module Pragmater
  module CLI
    module Actions
      # Handles insert or remove actions.
      class Run
        include Pragmater::Import[:logger]

        def initialize runner: Runner.new, **dependencies
          super(**dependencies)
          @runner = runner
        end

        def call(configuration) = runner.call(configuration) { |path| logger.info { path } }

        private

        attr_reader :runner
      end
    end
  end
end
