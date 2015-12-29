# Pragmater

[![Gem Version](https://badge.fury.io/rb/pragmater.svg)](http://badge.fury.io/rb/pragmater)
[![Code Climate GPA](https://codeclimate.com/github/bkuhlmann/pragmater.svg)](https://codeclimate.com/github/bkuhlmann/pragmater)
[![Code Climate Coverage](https://codeclimate.com/github/bkuhlmann/pragmater/coverage.svg)](https://codeclimate.com/github/bkuhlmann/pragmater)
[![Gemnasium Status](https://gemnasium.com/bkuhlmann/pragmater.svg)](https://gemnasium.com/bkuhlmann/pragmater)
[![Travis CI Status](https://secure.travis-ci.org/bkuhlmann/pragmater.svg)](https://travis-ci.org/bkuhlmann/pragmater)
[![Patreon](https://img.shields.io/badge/patreon-donate-brightgreen.svg)](https://www.patreon.com/bkuhlmann)

A command line interface for adding [directive pragma](https://en.wikipedia.org/wiki/Directive_(programming)) comments
(a.k.a. *magic comments*) to source files. Examples:

    #! /usr/bin/ruby
    # frozen_string_literal: true
    # encoding: UTF-8

With the release of [Ruby 2.3.0](https://www.ruby-lang.org/en/news/2015/12/25/ruby-2-3-0-released), support for frozen
strings are now supported via a pragma comment. This gems provides a easy way to add pragma comments to single or
multiple Ruby source files in order to benefit from improved memory and concurrency performance.

<!-- Tocer[start]: Auto-generated, don't remove. -->

# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Setup](#setup)
- [Usage](#usage)
  - [Command Line Interface (CLI)](#command-line-interface-cli)
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
- Supports removing a pragma comment or multiple pragma comments from single or multiple source files.
- Supports whitelist filtering. Defaults to `*.rb` and `*.rake` files.
- Ensures duplicate pragma comments never exist.
- Ensures pragma commments are always properly formatted.

# Requirements

0. [MRI 2.3.x](https://www.ruby-lang.org)

# Setup

For a secure install, type the following (recommended):

    gem cert --add <(curl -Ls https://www.alchemists.io/gem-public.pem)
    gem install pragmater --trust-policy MediumSecurity

NOTE: A HighSecurity trust policy would be best but MediumSecurity enables signed gem verification while
allowing the installation of unsigned dependencies since they are beyond the scope of this gem.

For an insecure install, type the following (not recommended):

    gem install pragmater

# Usage

## Command Line Interface (CLI)

From the command line, type: `pragmater help`

    pragmater -a, [--add=ADD]        # Add pragma comments to source file(s).
    pragmater -e, [--edit]           # Edit Pragmater settings in default editor.
    pragmater -h, [--help=HELP]      # Show this message or get help for a command.
    pragmater -r, [--remove=REMOVE]  # Remove pragma comments from source file(s).
    pragmater -v, [--version]        # Show Pragmater version.

Both the `--add` and `--remove` options provide the ability to supply specific pragma comments and/or whitelisted file
extensions:

    -c, [--comments=one two three]    # Pragma comments
    -e, [--extensions=one two three]  # File extension whitelist
                                      # Default: [".rb", ".rake"]

# Tests

To test, run:

    bundle exec rake

# Versioning

Read [Semantic Versioning](http://semver.org) for details. Briefly, it means:

- Patch (x.y.Z) - Incremented for small, backwards compatible bug fixes.
- Minor (x.Y.z) - Incremented for new, backwards compatible public API enhancements and/or bug fixes.
- Major (X.y.z) - Incremented for any backwards incompatible public API changes.

# Code of Conduct

Please note that this project is released with a [CODE OF CONDUCT](CODE_OF_CONDUCT.md). By participating in this project
you agree to abide by its terms.

# Contributions

Read [CONTRIBUTING](CONTRIBUTING.md) for details.

# License

Copyright (c) 2015 [Alchemists](https://www.alchemists.io).
Read the [LICENSE](LICENSE.md) for details.

# History

Read the [CHANGELOG](CHANGELOG.md) for details.
Built with [Gemsmith](https://github.com/bkuhlmann/gemsmith).

# Credits

Developed by [Brooke Kuhlmann](https://www.alchemists.io) at [Alchemists](https://www.alchemists.io).
