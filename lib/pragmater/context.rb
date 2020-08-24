# frozen_string_literal: true

module Pragmater
  # Provides context for runner.
  Context = Struct.new :action, :root_dir, :comments, :includes, keyword_init: true do
    def initialize *arguments
      super

      self[:root_dir] ||= "."
      self[:comments] = Array comments
      self[:includes] = Array includes
    end
  end
end
