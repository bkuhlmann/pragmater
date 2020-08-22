# frozen_string_literal: true

module Pragmater
  module CLI
    # The command line interface for this gem.
    class Shell
      def initialize merger: Options::Merger.new, runner: Runner, helper: Helper.new
        @merger = merger
        @runner = runner
        @helper = helper
      end

      def call arguments = []
        case merger.call arguments
          in insert: path, **options then insert_pragmas options, path
          in remove: path, **options then remove_pragmas options, path
          in config:, edit:, **remainder then edit_configuration
          in config:, info:, **remainder then print_configuration
          in version:, **remainder then print_version
          in help:, **remainder then print_usage
          else print_usage
        end
      end

      private

      attr_reader :merger, :runner, :helper

      def insert_pragmas options, path
        runner.for(**options.merge(action: :insert, root_dir: path))
              .call
              .map { |file| helper.info "Processed: #{file}." }
      end

      def remove_pragmas options, path
        runner.for(**options.merge(action: :remove, root_dir: path))
              .call
              .map { |file| helper.info "Processed: #{file}." }
      end

      def edit_configuration
        helper.run "#{ENV["EDITOR"]} #{merger.configuration_path}"
      end

      def print_configuration
        merger.configuration_path.then do |path|
          return helper.info "No configuration found." unless path

          helper.info "#{path}\n"
          helper.info path.read
        end
      end

      def print_version
        helper.info Identity::VERSION_LABEL
      end

      def print_usage
        helper.info merger.usage
      end
    end
  end
end
