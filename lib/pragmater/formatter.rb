# frozen_string_literal: true

module Pragmater
  # Formats pragma comments in a consistent manner.
  class Formatter
    def self.shebang_format
      %r(\A\#\!\s?\/.*ruby\Z)
    end

    def self.pragma_format
      /
        \A       # Start of line.
        \#       # Start of comment.
        \s?      # Space - optional.
        \w+      # Key - 1 or more word characters only.
        \:       # Key and value delimiter.
        \s?      # Space - optional.
        [\w\-]+  # Value - 1 or more word or dash characters.
        \Z       # End of line.
      /x
    end

    def self.valid_formats
      Regexp.union shebang_format, pragma_format
    end

    def initialize string
      @string = string
    end

    def format_shebang
      return string unless string.match?(self.class.shebang_format)

      _, path = string.split "!"
      "#! #{path.strip}"
    end

    def format_pragma
      return string unless string.match?(self.class.pragma_format)

      key, value = string.split ":"
      "# #{key.gsub(/\#\s?/, "")}: #{value.strip}"
    end

    def format
      klass = self.class

      case string
        when klass.shebang_format then format_shebang
        when klass.pragma_format then format_pragma
        else string
      end
    end

    private

    attr_reader :string
  end
end
