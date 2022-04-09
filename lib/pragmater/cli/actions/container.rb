# frozen_string_literal: true

require "dry/container"

module Pragmater
  module CLI
    module Actions
      # Provides a single container with application and action specific dependencies.
      module Container
        extend Dry::Container::Mixin

        config.registry = ->(container, key, value, _options) { container[key.to_s] = value }

        merge Pragmater::Container

        register(:config) { Config.new }
        register(:run) { Run.new }
      end
    end
  end
end
