# frozen_string_literal: true

module Pragmater
  # Writes formatted pragma comments to source file.
  # :reek:TooManyInstanceVariables
  # :reek:MissingSafeMethod
  class Writer
    # rubocop:disable Metrics/ParameterLists
    def initialize file_path, new_comments, formatter: Formatter, commenter: Commenter
      @file_path = file_path
      @file_lines = File.readlines file_path
      @formatter = formatter
      @commenter = commenter
      @old_comments = file_comments
      @new_comments = new_comments
    end
    # rubocop:enable Metrics/ParameterLists

    def add
      comments = format commenter.new(old_comments, new_comments).add
      lines = comments + file_lines_without_comments
      insert_spacing! lines, comments
      write { lines.join }
    end

    def remove
      lines = format(commenter.new(old_comments, new_comments).remove) + file_lines_without_comments
      remove_spacing! lines
      write { lines.join }
    end

    private

    attr_reader :file_path, :file_lines, :new_comments, :old_comments, :formatter, :commenter

    def file_comments
      file_lines.select { |line| line =~ formatter.valid_formats }
    end

    def file_lines_without_comments
      file_lines.reject { |line| old_comments.include? line }
    end

    # :reek:UtilityFunction
    def format lines
      lines.map { |line| "#{line}\n" }
    end

    # :reek:UtilityFunction
    def insert_spacing! lines, comments
      comment_count = comments.size

      return if comments.empty?
      return if lines.size == 1
      return if lines[comment_count] == "\n"

      lines.insert comment_count, "\n"
    end

    # :reek:UtilityFunction
    def remove_spacing! lines
      lines.delete_at 0 if lines.first == "\n"
    end

    def write
      File.open(file_path, "w") { |file| file.write yield }
    end
  end
end
