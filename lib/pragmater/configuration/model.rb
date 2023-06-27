# frozen_string_literal: true

module Pragmater
  module Configuration
    # Defines the content of the configuration for use throughout the gem.
    Model = Struct.new :comments, :patterns, :root_dir do
      def initialize(**)
        super
        self[:comments] = Array comments
        self[:patterns] = Array patterns
      end
    end
  end
end
