# Pragmater

[![Gem Version](https://badge.fury.io/rb/pragmater.svg)](http://badge.fury.io/rb/pragmater)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/pragmater.svg)](https://codeclimate.com/github/bkuhlmann/pragmater)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/pragmater/coverage.svg)](https://codeclimate.com/github/bkuhlmann/pragmater)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/pragmater.svg)](https://gemnasium.com/bkuhlmann/pragmater)
[![Circle CI Status](https://circleci.com/gh/bkuhlmann/pragmater.svg?style=svg)](https://circleci.com/gh/bkuhlmann/pragmater)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

A command line interface for managing/formatting source file
[directive pragma](https://en.wikipedia.org/wiki/Directive_(programming)) comments
(a.k.a. *magic comments*). Examples:

    #! /usr/bin/env ruby
    # frozen_string_literal: true
    # encoding: UTF-8

With [Ruby 2.3.0](https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released), frozen strings
are supported via a pragma comment. This gem provides an easy way to add pragma comments to single
or multiple Ruby source files in order to benefit from improved memory and concurrency performance.

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Screencasts](#screencasts)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
  - [Command Line Interface (CLI)](#command-line-interface-cli)
  - [Customization](#customization)
  - [Frozen String Literals](#frozen-string-literals)
  - [Available Comments](#available-comments)
- [Tests](#tests)
- [Versioning](#versioning)
- [Code of Conduct](#code-of-conduct)
- [Contributions](#contributions)
- [License](#license)
- [History](#history)
- [Credits](#credits)

<!-- Tocer[finish]: Auto-generated, don't remove. -->

# Features

- Supports adding a pragma comment or multiple pragma comments to single or multiple source files.
- Supports removing a pragma comment(s) from single or multiple source files.
- Supports whitelist filtering. Defaults to any file.
- Ensures duplicate pragma comments never exist.
- Ensures pragma comments are consistently formatted.

# Screencasts

[![asciicast](https://asciinema.org/a/91755.png)](https://asciinema.org/a/91755)

# Requirements

0. [Ruby 2.4.x](https://www.ruby-lang.org)

# Setup

For a secure install, type the following (recommended):

    gem cert --add <(curl --location --silent https://www.alchemists.io/gem-public.pem)
    gem install pragmater --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification
while allowing the installation of unsigned dependencies since they are beyond the scope of this
gem.

For an insecure install, type the following (not recommended):

    gem install pragmater

# Usage

## Command Line Interface (CLI)

From the command line, type: `pragmater help`

    pragmater -a, [--add=PATH]      # Add pragma comments to source file(s).
    pragmater -c, [--config]        # Manage gem configuration.
    pragmater -h, [--help=COMMAND]  # Show this message or get help for a command.
    pragmater -r, [--remove=PATH]   # Remove pragma comments from source file(s).
    pragmater -v, [--version]       # Show gem version.

Both the `--add` and `--remove` commands support options for specifying pragma comments and/or
whitelisted files (viewable by running `pragmater --help --add` or `pragmater --help --remove`):

    -c, [--comments=one two three]   # Pragma comments
    -w, [--whitelist=one two three]  # File whitelist

## Customization

This gem can be configured via a global configuration:

    ~/.config/pragmater/configuration.yml

It can also be configured via [XDG environment variables](https://github.com/bkuhlmann/runcom#xdg)
as provided by the [Runcom](https://github.com/bkuhlmann/runcom) gem.

The default configuration is as follows:

    :add:
      :comments: []
      :whitelist: []
    :remove:
      :comments: []
      :whitelist: []

Feel free to take this default configuration, modify, and save as your own custom
`configuration.yml`.

The `configuration.yml` file can be configured as follows:

- `add`: Defines global/local comments and/or whitelists when adding pragma comments. The `comments`
  and `whitelist` options can be either a single string or an array of values.
- `remove`: Defines global/local comments and/or whitelists when removing pragma comments. The
  `comments` and `whitelist` options can be either a single string or an array of values.

## Frozen String Literals

With Ruby 2.3.0, support for frozen strings was added. These comments are meant to be placed at the
top of each source file. Example:

    # frozen_string_literal: true

This is great for *selective* enablement of frozen string literals but might be too much work for
some (even with the aid of this gem). As an alternative, frozen string literals can be enabled via
the following Ruby command line option:

    --enable=frozen-string-literal

It is important to note that, once enabled, it freezes strings program-wide -- It's an all or
nothing option.

Regardless of whether you leverage the capabilities of this gem or the Ruby command line option
mentioned above, the following Ruby command line option is available to aid debugging and tracking
down frozen string literal issues:

    --debug=frozen-string-literal

## Available Comments

With Ruby 2.3 and higher, the following comments are available:

- `# encoding:` Defaults to `UTF-8` but any supported encoding can be used. For a list of values,
  launch an IRB session and run `Encoding.name_list`.
- `# coding:` The shorthand for `# encoding:`. Supports the same values as mentioned above.
- `# frozen_string_literal:` Defaults to `false` but can take either `true` or `false` as a value.
  When enabled, Ruby will throw errors when strings are used in a mutable fashion.
- `# warn_indent:` Defaults to `false` but can take either `true` or `false` as a value. When
  enabled, and running Ruby with the `-w` option, it'll throw warnings for code that isn't indented
  by two spaces.

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Major (X.y.z) - Incremented for any backwards incompatible public API changes.
- Minor (x.Y.z) - Incremented for new, backwards compatible, public API enhancements/fixes.
- Patch (x.y.Z) - Incremented for small, backwards compatible, bug fixes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By
participating in this project you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2015 [Alchemists](https://www.alchemists.io).
Read [LICENSE](LICENSE.md) for details.

# History

Read [CHANGES](CHANGES.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at
[Alchemists](https://www.alchemists.io).
