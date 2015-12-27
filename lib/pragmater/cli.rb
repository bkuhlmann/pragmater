# frozen_string_literal: true

require "yaml"
require "thor"
require "thor/actions"
require "thor_plus/actions"

module Pragmater
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name Pragmater::Identity.version_label

    def initialize args = [], options = {}, config = {}
      super args, options, config
    end

    desc "-e, [--edit]", "Edit #{Pragmater::Identity.label} settings in default editor."
    map %w(-e --edit) => :edit
    def edit
      `#{editor} $HOME/#{Pragmater::Identity.file_name}`
    end

    desc "-v, [--version]", "Show #{Pragmater::Identity.label} version."
    map %w(-v --version) => :version
    def version
      say Pragmater::Identity.version_label
    end

    desc "-h, [--help=HELP]", "Show this message or get help for a command."
    map %w(-h --help) => :help
    def help task = nil
      say && super
    end
  end
end
