<p align="center">
  <img src="https://www.alchemists.io/images/projects/pragmater/icon.png" alt="Pragmater Icon"/>
</p>

# Pragmater

[![Gem Version](https://badge.fury.io/rb/pragmater.svg)](http://badge.fury.io/rb/pragmater)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/pragmater.svg?style=svg)](https://circleci.com/gh/bkuhlmann/pragmater)

A command line interface for managing/formatting source file [directive
pragmas](https://en.wikipedia.org/wiki/Directive_(programming)) (a.k.a. *magic comments*). Examples:

    #! /usr/bin/env ruby
    # frozen_string_literal: true
    # encoding: UTF-8

With [Ruby 2.3.0](https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released), frozen strings
are supported via a pragma. This gem provides an easy way to add pragmas to single or multiple Ruby
source files in order to benefit from improved memory and concurrency performance.

<!-- Tocer[start]: Auto-generated, don't remove. -->

## Table of Contents

  - [Features](#features)
  - [Screencasts](#screencasts)
  - [Requirements](#requirements)
  - [Setup](#setup)
    - [Production](#production)
    - [Development](#development)
  - [Usage](#usage)
    - [Command Line Interface (CLI)](#command-line-interface-cli)
    - [Customization](#customization)
    - [Available Pragmas](#available-pragmas)
    - [Syntax](#syntax)
    - [Precedence](#precedence)
    - [Frozen String Literals](#frozen-string-literals)
  - [Tests](#tests)
  - [Versioning](#versioning)
  - [Code of Conduct](#code-of-conduct)
  - [Contributions](#contributions)
  - [License](#license)
  - [History](#history)
  - [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

## Features

- Supports adding a pragma or multiple pragmas to single or multiple source files.
- Supports removing pragma(s) from single or multiple source files.
- Supports file list filtering. Defaults to any file.
- Ensures duplicate pragmas never exist.
- Ensures pragmas are consistently formatted.

## Screencasts

[![asciicast](https://asciinema.org/a/278662.svg)](https://asciinema.org/a/278662)

## Requirements

1. [Ruby 2.7.x](https://www.ruby-lang.org)

## Setup

### Production

To install, run:

    gem install pragmater

### Development

To contribute, run:

    git clone https://github.com/bkuhlmann/pragmater.git
    cd pragmater
    bin/setup

You can also use the IRB console for direct access to all objects:

    bin/console

## Usage

### Command Line Interface (CLI)

From the command line, type: `pragmater help`

    pragmater -a, [--add=PATH]      # Add comments to source file(s).
    pragmater -c, [--config]        # Manage gem configuration.
    pragmater -h, [--help=COMMAND]  # Show this message or get help for a command.
    pragmater -r, [--remove=PATH]   # Remove comments from source file(s).
    pragmater -v, [--version]       # Show gem version.

Both the `--add` and `--remove` commands support options for specifying pragmas and/or included
files (viewable by running `pragmater --help --add` or `pragmater --help --remove`):

    -c, [--comments=one two three]  # Define desired comments
    -i, [--includes=one two three]  # Include specific files and/or directories

Example (same options could be used for the `--remove` command too):

    pragmater --add --comments "# frozen_string_literal: true" --includes "Gemfile" "Guardfile" "Rakefile" ".gemspec" "config.ru" "bin/**/*" "**/*.rake" "**/*.rb"

The `--add` and `--remove` commands default to the current working directory so a path isn't
necessary unless you want to run Pragmater on a directory structure *other than* your current
working directory.

### Customization

This gem can be configured via a global configuration:

    ~/.config/pragmater/configuration.yml

It can also be configured via [XDG](https://github.com/bkuhlmann/xdg) environment variables.

The default configuration is as follows:

    :add:
      :comments: []
      :includes: []
    :remove:
      :comments: []
      :includes: []

Feel free to take this default configuration, modify, and save as your own custom
`configuration.yml`.

The `configuration.yml` file can be configured as follows:

- `add`: Defines global/local comments and/or file include lists when adding pragmas. The
  `comments` and `includes` options can be either a single string or an array.
- `remove`: Defines global/local comments and/or file include lists when removing pragmas.
  The `comments` and `includes` options can be either a single string or an array.

### Available Pragmas

With Ruby 2.3 and higher, the following pragmas are available:

- `# encoding:` Defaults to `UTF-8` but any supported encoding can be used. For a list of values,
  launch an IRB session and run `Encoding.name_list`.
- `# coding:` The shorthand for `# encoding:`. Supports the same values as mentioned above.
- `# frozen_string_literal:` Defaults to `false` but can take either `true` or `false` as a value.
  When enabled, Ruby will throw errors when strings are used in a mutable fashion.
- `# warn_indent:` Defaults to `false` but can take either `true` or `false` as a value. When
  enabled, and running Ruby with the `-w` option, it'll throw warnings for code that isn't indented
  by two spaces.

### Syntax

The pragma syntax allows for two kinds of styles. Example:

    # encoding: UTF-8
    # -*- encoding: UTF-8 -*-

Only the former syntax is supported by this gem as the latter syntax is more verbose and requires
additional typing.

### Precedence

When different multiple pragmas are defined, they all take precedence:

    # encoding: binary
    # frozen_string_literal: true

In the above example, both *binary* encoding and *frozen string literals* behavior will be applied.

When defining multiple pragmas that are similar, behavior can differ based on the *kind* of pragma
used. The following walks through each use case so you know what to expect:

    # encoding: binary
    # encoding: UTF-8

In the above example, only the *binary* encoding will be applied while the *UTF-8* encoding will be
ignored (same principle applies for the `coding` pragma too).

    # frozen_string_literal: false
    # frozen_string_literal: true

In the above example, frozen string literal support *will be enabled* instead of being disabled.

    # warn_indent: false
    # warn_indent: true

In the above example, indentation warnings *will be enabled* instead of being disabled.

### Frozen String Literals

Support for frozen string literals was added in Ruby 2.3.0. The ability to freeze strings within a
source can be done by placing a frozen string pragma at the top of each source file. Example:

    # frozen_string_literal: true

This is great for *selective* enablement of frozen string literals but might be too much work for
some (even with the aid of this gem). As an alternative, frozen string literals can be enabled via
the following Ruby command line option:

    --enable=frozen-string-literal

It is important to note that, once enabled, this freezes strings program-wide -- It's an all or
nothing option.

Regardless of whether you leverage the capabilities of this gem or the Ruby command line option
mentioned above, the following Ruby command line option is available to aid debugging and tracking
down frozen string literal issues:

    --debug=frozen-string-literal

Ruby 2.3.0 also added the following methods to the `String` class:

- `String#+@`: Answers a duplicated, mutable, string if not already frozen. Example:

        immutable = "test".freeze
        mutable = +immutable
        mutable.capitalize! # => "Test"

- `String#-@`: Answers a immutable string if not already frozen. Example:

        mutable = "test"
        immutable = -mutable
        immutable.capitalize! # => FrozenError

You can also use the methods, shown above, for variable initialization. Example:

    immutable = -"test"
    mutable = +"test"

Despite Ruby allowing you to do this, it is *not recommended* to use the above examples as it leads
to hard to read code. Instead use the following:

    immutable = "test".freeze
    mutable = "test"

While this requires extra typing, it expresses intent more clearly. There is a slight caveat to this
rule in which the use of `String#-@` was [enhanced in Ruby 2.5.0](http://bit.ly/2DGAjgG) to
*deduplicate* all instances of the same string thus reducing your memory footprint. This can be
valuable in situations where you are not using the frozen string comment and need to selectively
freeze strings.

## Tests

To test, run:

    bundle exec rake

## Versioning

Read [Semantic Versioning](https://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

## Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

## Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

## License

Copyright 2015 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

## History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

## Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
