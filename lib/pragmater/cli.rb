# frozen_string_literal: true

require "pathname"
require "thor"
require "thor/actions"
require "runcom"

module Pragmater
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions

    package_name Identity::VERSION_LABEL

    # rubocop:disable Metrics/MethodLength
    def self.configuration
      Runcom::Config.new "#{Identity::NAME}/configuration.yml",
                         defaults: {
                           add: {
                             comments: "",
                             includes: []
                           },
                           remove: {
                             comments: "",
                             includes: []
                           }
                         }
    end
    # rubocop:enable Metrics/MethodLength

    def initialize args = [], options = {}, config = {}
      super args, options, config
      @configuration = self.class.configuration
    rescue Runcom::Errors::Base => error
      abort error.message
    end

    desc "-i, [--insert=PATH]", "Insert comments into source file(s)."
    map %w[-i --insert] => :insert
    method_option :comments,
                  aliases: "-c",
                  desc: "Define desired comments",
                  type: :array,
                  default: configuration.to_h.dig(:insert, :comments)
    method_option :includes,
                  aliases: "-i",
                  desc: "Include specific files and/or directories",
                  type: :array,
                  default: configuration.to_h.dig(:insert, :includes)
    def insert path = "."
      settings = configuration.merge(
        insert: {comments: options.comments, includes: options.includes}
      ).to_h

      runner = Runner.new comments: settings.dig(:insert, :comments),
                          includes: settings.dig(:insert, :includes)

      runner.call(path, action: :insert) { |file| say_status :info, "Processed: #{file}.", :green }
    end

    desc "-r, [--remove=PATH]", "Remove comments from source file(s)."
    map %w[-r --remove] => :remove
    method_option :comments,
                  aliases: "-c",
                  desc: "Define desired comments",
                  type: :array,
                  default: configuration.to_h.dig(:remove, :comments)
    method_option :includes,
                  aliases: "-i",
                  desc: "Include specific files and/or directories",
                  type: :array,
                  default: configuration.to_h.dig(:remove, :includes)
    def remove path = "."
      settings = configuration.merge(
        remove: {comments: options.comments, includes: options.includes}
      ).to_h

      runner = Runner.new comments: settings.dig(:remove, :comments),
                          includes: settings.dig(:remove, :includes)

      runner.call(path, action: :remove) { |file| say_status :info, "Processed: #{file}.", :green }
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit,
                  aliases: "-e",
                  desc: "Edit gem configuration.",
                  type: :boolean,
                  default: false
    method_option :info,
                  aliases: "-i",
                  desc: "Print gem configuration.",
                  type: :boolean,
                  default: false
    def config
      path = configuration.current

      if options.edit? then `#{ENV["EDITOR"]} #{path}`
      elsif options.info?
        path ? say(path) : say("Configuration doesn't exist.")
      else help :config
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Identity::VERSION_LABEL
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
