# frozen_string_literal: true

module Pragmater
  # Gem identity information.
  module Identity
    def self.name
      "pragmater"
    end

    def self.label
      "Pragmater"
    end

    def self.version
      "3.0.0"
    end

    def self.version_label
      "#{label} #{version}"
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end
