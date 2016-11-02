# frozen_string_literal: true

require "refinements/hashes"

module Pragmater
  # Default gem configuration with support for custom settings.
  class Configuration
    using Refinements::Hashes

    def initialize file_name = Identity.file_name, defaults: {}
      @file_name = file_name
      @defaults = defaults
      @settings = defaults.deep_merge load_settings
    end

    def local_file_path
      File.join Dir.pwd, file_name
    end

    def global_file_path
      File.join ENV["HOME"], file_name
    end

    def computed_file_path
      local? ? local_file_path : global_file_path
    end

    def local?
      File.exist? local_file_path
    end

    def global?
      File.exist? global_file_path
    end

    def merge custom_settings
      settings.deep_merge custom_settings
    end

    def to_h
      settings
    end

    private

    attr_reader :file_name, :defaults, :settings

    def load_settings
      yaml = YAML.load_file computed_file_path
      yaml.is_a?(Hash) ? yaml : {}
    rescue
      defaults
    end
  end
end
