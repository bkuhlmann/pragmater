# frozen_string_literal: true

module Pragmater
  module Processors
    # Inserts new pragma comments.
    class Inserter
      def initialize comments, body
        @comments = comments
        @body = body
      end

      def call
        body.first.then do |first|
          comments.append "\n" unless first == "\n" || body.empty?
          comments + body
        end
      end

      private

      attr_reader :comments, :body
    end
  end
end
