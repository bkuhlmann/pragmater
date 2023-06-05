# frozen_string_literal: true

module Pragmater
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Model = Struct.new(
      :action_config,
      :action_help,
      :action_insert,
      :action_remove,
      :action_version,
      :comments,
      :includes,
      :root_dir
    ) do
      def initialize(**)
        super
        freeze
      end
    end
  end
end
