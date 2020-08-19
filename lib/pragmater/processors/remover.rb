# frozen_string_literal: true

module Pragmater
  module Processors
    # Removes existing pragma comments.
    class Remover
      def initialize comments, body
        @comments = comments
        @body = body
      end

      def call
        body.first.then do |first_line|
          body.delete_at 0 if first_line == "\n" && comments.empty?
          comments + body
        end
      end

      private

      attr_reader :comments, :body
    end
  end
end
