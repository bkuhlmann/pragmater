# frozen_string_literal: true

require "pathname"
require "thor"
require "thor/actions"
require "runcom"

module Pragmater
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity.version_label

    def self.configuration
      Runcom::Configuration.new project_name: Identity.name, defaults: {
        add: {
          comments: "",
          whitelist: []
        },
        remove: {
          comments: "",
          whitelist: []
        }
      }
    end

    def initialize args = [], options = {}, config = {}
      super args, options, config
      @configuration = self.class.configuration
    rescue Runcom::Errors::Base => error
      abort error.message
    end

    desc "-a, [--add=PATH]", "Add pragma comments to source file(s)."
    map %w[-a --add] => :add
    method_option :comments,
                  aliases: "-c",
                  desc: "Pragma comments",
                  type: :array,
                  default: []
    method_option :whitelist,
                  aliases: "-w",
                  desc: "File whitelist",
                  type: :array,
                  default: []
    def add path = "."
      settings = configuration.merge add: {
        comments: options[:comments],
        whitelist: options[:whitelist]
      }

      runner = Runner.new path,
                          comments: settings.dig(:add, :comments),
                          whitelist: settings.dig(:add, :whitelist)

      runner.run(action: :add) { |file| say_status :info, "Processed: #{file}.", :green }
    end

    desc "-r, [--remove=PATH]", "Remove pragma comments from source file(s)."
    map %w[-r --remove] => :remove
    method_option :comments,
                  aliases: "-c",
                  desc: "Pragma comments",
                  type: :array,
                  default: []
    method_option :whitelist,
                  aliases: "-w",
                  desc: "File whitelist",
                  type: :array,
                  default: []
    def remove path = "."
      settings = configuration.merge remove: {
        comments: options[:comments],
        whitelist: options[:whitelist]
      }

      runner = Runner.new path,
                          comments: settings.dig(:remove, :comments),
                          whitelist: settings.dig(:remove, :whitelist)

      runner.run(action: :remove) { |file| say_status :info, "Processed: #{file}.", :green }
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit,
                  aliases: "-e",
                  desc: "Edit gem configuration.",
                  type: :boolean, default: false
    method_option :info,
                  aliases: "-i",
                  desc: "Print gem configuration.",
                  type: :boolean, default: false
    def config
      path = configuration.path

      if options.edit? then `#{ENV["EDITOR"]} #{path}`
      elsif options.info?
        path ? say(path) : say("Configuration doesn't exist.")
      else help(:config)
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity.version_label
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
    end

    private

    attr_reader :configuration
  end
end
