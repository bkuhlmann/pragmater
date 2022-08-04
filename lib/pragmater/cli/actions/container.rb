# frozen_string_literal: true

require "dry/container"

module Pragmater
  module CLI
    module Actions
      # Provides a single container with application and action specific dependencies.
      module Container
        extend Dry::Container::Mixin

        merge Pragmater::Container

        register(:config) { Config.new }
        register(:run) { Run.new }
      end
    end
  end
end
