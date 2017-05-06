# v3.1.0 (2017-05-06)

- Fixed Rubocop Style/AutoResourceCleanup issues.
- Fixed Travis CI configuration to not update gems.
- Added code quality Rake task.
- Updated Guardfile to always run RSpec with documentation format.
- Updated README semantic versioning order.
- Updated RSpec configuration to output documentation when running.
- Updated RSpec spec helper to enable color output.
- Updated Rubocop configuration.
- Updated Rubocop to import from global configuration.
- Updated contributing documentation.
- Updated to Gemsmith 9.0.0.
- Updated to Ruby 2.4.1.
- Removed Code Climate code comment checks.
- Removed `.bundle` directory from `.gitignore`.

# v3.0.0 (2017-01-22)

- Updated Rubocop Metrics/LineLength to 100 characters.
- Updated Rubocop Metrics/ParameterLists max to three.
- Updated Travis CI configuration to use latest RubyGems version.
- Updated gemspec to require Ruby 2.4.0 or higher.
- Updated to Rubocop 0.47.
- Updated to Ruby 2.4.0.
- Removed Rubocop Style/Documentation check.

# v2.2.0 (2016-12-18)

- Fixed Rakefile support for RSpec, Reek, Rubocop, and SCSS Lint.
- Added `Gemfile.lock` to `.gitignore`.
- Updated Travis CI configuration to use defaults.
- Updated gem dependencies.
- Updated to Gemsmith 8.2.x.
- Updated to Rake 12.x.x.
- Updated to Rubocop 0.46.x.
- Updated to Ruby 2.3.2.
- Updated to Ruby 2.3.3.

# v2.1.1 (2016-11-13)

- Fixed gem requirements order.

# v2.1.0 (2016-11-13)

- Fixed Ruby pragma.
- Added Code Climate engine support.
- Added Reek support.
- Updated `--config` command to use computed path.
- Updated to Code Climate Test Reporter 1.0.0.
- Updated to Gemsmith 8.0.0.
- Removed CLI defaults (using configuration instead).
- Refactored source requirements.

# v2.0.0 (2016-11-05)

- Fixed Rakefile to safely load Gemsmith tasks.
- Added CLI `--config` option.
- Added Runcom gem.
- Added `--config` `--info` option.
- Added ability to question configuration for global and local file usage.
- Added frozen string literal pragma.
- Updated README to mention "Ruby" instead of "MRI".
- Updated README versioning documentation.
- Updated RSpec temp directory to use Bundler root path.
- Updated Rubocop configuration to exclude fixtures.
- Updated gemspec with conservative versions.
- Updated to RSpec 3.5.0.
- Updated to Refinements 3.0.0.
- Updated to Rubocop 0.44.
- Updated to Thor+ 4.0.0.
- Removed CHANGELOG.md (use CHANGES.md instead).
- Removed CLI `--edit` option.
- Removed Climate Control gem.
- Removed Rake console task.
- Removed Refinements gem.
- Removed `Pragmater::Configuration`.
- Removed gemspec description.
- Removed rb-fsevent development dependency from gemspec.
- Removed terminal notifier gems from gemspec.
- Refactored CLI defaults as a class method.
- Refactored RSpec spec helper configuration.
- Refactored `Configuration` to answer hash.
- Refactored default configuration settings to CLI.
- Refactored gemspec to use default security keys.

# v1.3.0 (2016-06-16)

- Fixed CLI help documentation.
- Fixed CLI invalid path error message.
- Added README documentation for available pragma comments.
- Updated README documentation (minor tweaks and clarifications).
- Updated to Gemsmith 7.7.0.
- Updated to Ruby 2.3.1.

# v1.2.0 (2016-04-24)

- Fixed Rubocop Style/RegexpLiteral issues.
- Fixed contributing guideline links.
- Fixed global settings infecting configuration spec.
- Added GitHub issue and pull request templates.
- Added README Screencasts section.
- Added Rubocop Style/SignalException cop style.
- Added bond, wirb, hirb, and awesome_print development dependencies.
- Updated GitHub issue and pull request templates.
- Updated README secure gem install documentation.
- Updated Rubocop PercentLiteralDelimiters and AndOr styles.
- Updated to Code of Conduct, Version 1.4.0.
- Removed gem label from CLI edit and version descriptions

# v1.1.0 (2016-01-20)

- Fixed gem secure install issues.

# v1.0.0 (2016-01-18)

- Fixed CLI info output to match error output format.
- Fixed README URL to public gem certificate.
- Fixed bug with commenter adding bogus comments.
- Fixed bug with formatter matching incorrect pragma value.
- Fixed bug with not adding/removing new lines with pragmas.
- Fixed inserting of an extra blank line for empty files.
- Fixed processing of invalid file formats.
- Added IRB console for gem development environment.
- Added frozen string pragma to specs.
- Added gem configuration.
- Added global/local gem configuration support to CLI.
- Added valid formats to Formatter.
- Updated CLI file process messaging.
- Updated commenter specs with consistent descriptions.
- Removed --extensions option (use --whitelist instead).
- Removed CLI whitelist defaults.
- Removed RSpec default monkey patching behavior.
- Removed frozen string literal pragam from binary/rake files.

# v0.1.0 (2015-12-26)

- Initial version.
