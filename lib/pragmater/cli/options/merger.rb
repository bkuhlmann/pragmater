# frozen_string_literal: true

require "yaml"
require "pathname"
require "runcom"

module Pragmater
  module CLI
    module Options
      # Merges arguments with configuration for fully assembled configuration for use by shell.
      class Merger
        DEFAULTS = YAML.load_file(Pathname(__dir__).join("defaults.yml")).freeze
        CONFIGURATION = Runcom::Config.new "#{Identity::NAME}/configuration.yml", defaults: DEFAULTS

        def initialize configuration = CONFIGURATION, assembler = Assembler.new
          @configuration = configuration
          @assembler = assembler
        end

        def call arguments = []
          assembler.call(arguments).then do |options|
            case options
              in insert: path, **settings then build_insert_options path, settings
              in remove: path, **settings then build_remove_options path, settings
              else options
            end
          end
        end

        def configuration_path
          configuration.current
        end

        def usage
          assembler.to_s
        end

        private

        attr_reader :configuration, :assembler

        def build_insert_options path, options
          {insert: path, **configuration.to_h.fetch(:insert).merge(options)}
        end

        def build_remove_options path, options
          {remove: path, **configuration.to_h.fetch(:remove).merge(options)}
        end
      end
    end
  end
end
