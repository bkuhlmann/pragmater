# frozen_string_literal: true

require "pathname"
require "refinements/hashes"
require "refinements/structs"
require "runcom"
require "yaml"

module Pragmater
  module Configuration
    # Represents the fully assembled Command Line Interface (CLI) configuration.
    class Loader
      using Refinements::Hashes
      using Refinements::Structs

      DEFAULTS = YAML.load_file(Pathname(__dir__).join("defaults.yml")).freeze
      CLIENT = Runcom::Config.new "#{Identity::NAME}/configuration.yml", defaults: DEFAULTS

      def self.call = new.call

      def self.with_defaults = new(client: DEFAULTS)

      def initialize content: Content.new, client: CLIENT
        @content = content
        @client = client
      end

      def call = content.merge(**client.to_h.flatten_keys)

      private

      attr_reader :content, :client
    end
  end
end
