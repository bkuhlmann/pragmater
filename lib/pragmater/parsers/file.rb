# frozen_string_literal: true

module Pragmater
  module Parsers
    # Parses a file into pragma comment and body lines.
    class File
      def initialize pattern: Formatters::Main::PATTERN,
                     comments: Comments,
                     processor: Processors::Handler.new
        @pattern = pattern
        @comments = comments
        @processor = processor
      end

      def call path, new_comments, action:
        path.each_line
            .partition { |line| line.match? pattern }
            .then do |old_comments, body|
              processor.call action, wrap_in_new_line(old_comments, new_comments, action), body
            end
      end

      private

      attr_reader :pattern, :comments, :processor

      def wrap_in_new_line old_comments, new_comments, action
        comments.new(old_comments, new_comments).public_send(action).map { |line| "#{line}\n" }
      end
    end
  end
end
