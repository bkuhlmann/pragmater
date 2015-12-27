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
      "0.1.0"
    end

    def self.version_label
      "#{label} #{version}"
    end

    def self.file_name
      ".#{name}rc"
    end
  end
end
