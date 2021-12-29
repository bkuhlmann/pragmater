# frozen_string_literal: true

module Pragmater
  module CLI
    module Actions
      # Handles the config action.
      class Config
        def initialize client: Configuration::Loader::CLIENT, container: Container
          @client = client
          @container = container
        end

        def call selection
          case selection
            when :edit then edit
            when :view then view
            else logger.error { "Invalid configuration selection: #{selection}." }
          end
        end

        private

        attr_reader :client, :container

        def edit = kernel.system("$EDITOR #{client.current}")

        def view = kernel.system("cat #{client.current}")

        def kernel = container[__method__]

        def logger = container[__method__]
      end
    end
  end
end
