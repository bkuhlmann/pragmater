# frozen_string_literal: true

require "yaml"
require "pathname"
require "thor"
require "thor/actions"
require "thor_plus/actions"
require "runcom"

module Pragmater
  # The Command Line Interface (CLI) for the gem.
  class CLI < Thor
    include Thor::Actions
    include ThorPlus::Actions

    package_name Pragmater::Identity.version_label

    def initialize args = [], options = {}, config = {}
      super args, options, config
      @configuration = ::Runcom::Configuration.new file_name: Identity.file_name, defaults: defaults
    end

    desc "-a, [--add=PATH]", "Add pragma comments to source file(s)."
    map %w[-a --add] => :add
    method_option :comments, aliases: "-c", desc: "Pragma comments", type: :array, default: []
    method_option :whitelist, aliases: "-w", desc: "File extension whitelist", type: :array, default: []
    def add path
      settings = configuration.merge add: {comments: options[:comments], whitelist: options[:whitelist]}
      write path, settings, :add
    end

    desc "-r, [--remove=PATH]", "Remove pragma comments from source file(s)."
    map %w[-r --remove] => :remove
    method_option :comments, aliases: "-c", desc: "Pragma comments", type: :array, default: []
    method_option :whitelist, aliases: "-w", desc: "File extension whitelist", type: :array, default: []
    def remove path
      settings = configuration.merge remove: {comments: options[:comments], whitelist: options[:whitelist]}
      write path, settings, :remove
    end

    desc "-c, [--config]", "Manage gem configuration."
    map %w[-c --config] => :config
    method_option :edit, aliases: "-e", desc: "Edit gem configuration.", type: :boolean, default: false
    method_option :info, aliases: "-i", desc: "Print gem configuration info.", type: :boolean, default: false
    def config
      if options.edit? then `#{editor} #{configuration.computed_path}`
      elsif options.info? then say("Using: #{configuration.computed_path}.")
      else help(:config)
      end
    end

    desc "-v, [--version]", "Show gem version."
    map %w[-v --version] => :version
    def version
      say Pragmater::Identity.version_label
    end

    desc "-h, [--help=COMMAND]", "Show this message or get help for a command."
    map %w[-h --help] => :help
    def help task = nil
      say and super
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
      if path.file?
        update_file path, comments, action
      elsif path.directory?
        whitelisted_files(path, whitelist).each { |file_path| update_file file_path, comments, action }
      else
        error %(Invalid source path: "#{path}".)
      end
    end

    def write path, settings, action
      pathname = Pathname path
      comments = Array settings.dig(action).dig(:comments)
      whitelist = Array settings.dig(action).dig(:whitelist)

      update_files pathname, comments, whitelist, action
    end

    def defaults
      {
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
  end
end
