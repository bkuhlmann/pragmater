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
      "6.2.1"
    end

    def self.version_label
      "#{label} #{version}"
    end
  end
end
