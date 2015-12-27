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
      write { (format(commenter.new(old_comments, new_comments).add) + file_lines_without_comments).join }
    end

    def remove
      write { (format(commenter.new(old_comments, new_comments).remove) + file_lines_without_comments).join }
    end

    private

    attr_reader :file_path, :file_lines, :new_comments, :old_comments, :formatter, :commenter

    def file_comments
      file_lines.select { |line| line =~ formatter.shebang_format || line =~ formatter.pragma_format }
    end

    def file_lines_without_comments
      file_lines.reject { |line| old_comments.include? line }
    end

    def format lines
      lines.map { |line| "#{line}\n" }
    end

    def write
      File.open(file_path, "w") { |file| file.write yield }
    end
  end
end
