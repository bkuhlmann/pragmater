# frozen_string_literal: true

module Pragmater
  # Writes formatted pragma comments to source file.
  class Writer
    def initialize file_path, new_comments, formatter: Formatter, commenter: Commenter
      @file_path = file_path
      @file_lines = File.open(file_path).to_a
      @formatter = formatter
      @commenter = commenter
      @old_comments = file_comments
      @new_comments = new_comments
    end

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

    def format lines
      lines.map { |line| "#{line}\n" }
    end

    def insert_spacing! lines, comments
      return if comments.empty?
      return if lines[comments.size] == "\n"
      lines.insert comments.size, "\n"
    end

    def remove_spacing! lines
      lines.delete_at(0) if lines.first == "\n"
    end

    def write
      File.open(file_path, "w") { |file| file.write yield }
    end
  end
end
