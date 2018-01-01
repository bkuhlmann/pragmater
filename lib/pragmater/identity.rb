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
      "5.0.0"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
