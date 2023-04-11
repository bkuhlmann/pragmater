# frozen_string_literal: true

module Pragmater
  module CLI
    module Actions
      # Handles insert or remove actions.
      class Run
        include Pragmater::Import[:kernel]

        def initialize(runner: Runner.new, **)
          super(**)
          @runner = runner
        end

        def call(configuration) = runner.call(configuration) { |path| kernel.puts path }

        private

        attr_reader :runner
      end
    end
  end
end
