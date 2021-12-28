# frozen_string_literal: true

module Pragmater
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Content = Struct.new(
      :action_config,
      :action_help,
      :action_insert,
      :action_remove,
      :action_version,
      :comments,
      :includes,
      :root_dir,
      keyword_init: true
    ) do
      def initialize *arguments
        super
        freeze
      end
    end
  end
end
