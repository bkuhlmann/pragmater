# frozen_string_literal: true

require "yaml"
require "pathname"
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
      @configuration = Configuration.new Identity.file_name
    end

    desc "-a, [--add=ADD]", "Add pragma comments to source file(s)."
    map %w(-a --add) => :add
    method_option :comments, aliases: "-c", desc: "Pragma comments", type: :array, default: []
    method_option :whitelist, aliases: "-w", desc: "File extension whitelist", type: :array, default: []
    def add path
      settings = configuration.merge add: {comments: options[:comments], whitelist: options[:whitelist]}
      write path, settings, :add
    end

    desc "-r, [--remove=REMOVE]", "Remove pragma comments from source file(s)."
    map %w(-r --remove) => :remove
    method_option :comments, aliases: "-c", desc: "Pragma comments", type: :array, default: []
    method_option :whitelist, aliases: "-w", desc: "File extension whitelist", type: :array, default: []
    def remove path
      settings = configuration.merge remove: {comments: options[:comments], whitelist: options[:whitelist]}
      write path, settings, :remove
    end

    desc "-e, [--edit]", "Edit #{Pragmater::Identity.label} settings in default editor."
    map %w(-e --edit) => :edit
    def edit
      resource_file = File.join ENV["HOME"], Pragmater::Identity.file_name
      info "Editing: #{resource_file}..."
      `#{editor} #{resource_file}`
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

    private

    attr_reader :configuration

    def whitelisted_files path, whitelist
      file_filter = whitelist.empty? ? %(#{path}/**/*) : %(#{path}/**/*{#{whitelist.join ","}})
      Pathname.glob(file_filter).select(&:file?)
    end

    def update_file path, comments, action
      Writer.new(path, comments).public_send action
      info "Processed: #{path}."
    rescue ArgumentError => error
      formatted_message = error.message
      formatted_message[0] = formatted_message[0].capitalize
      error "#{formatted_message}: #{path}."
    end

    def update_files path, comments, whitelist, action
      case
        when path.file?
          update_file path, comments, action
        when path.directory?
          whitelisted_files(path, whitelist).each { |file_path| update_file file_path, comments, action }
        else
          error "Invalid path: #{path}."
      end
    end

    def write path, settings, action
      pathname = Pathname path
      comments = Array settings.dig(action).dig(:comments)
      whitelist = Array settings.dig(action).dig(:whitelist)

      update_files pathname, comments, whitelist, action
    end
  end
end
