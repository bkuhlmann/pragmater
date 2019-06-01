# 6.3.0 (2019-06-01)

- Fixed RSpec/ContextWording issues.
- Added Reek configuration.
- Updated contributing documentation.
- Updated to Reek 5.4.0.
- Updated to Rubocop 0.69.0.
- Updated to Rubocop Performance 1.3.0.
- Updated to Rubocop RSpec 1.33.0.
- Updated to Runcom 5.0.0.

# 6.2.1 (2019-05-01)

- Fixed Rubocop layout issues.
- Added Rubocop Performance gem.
- Added Ruby warnings to RSpec helper.
- Added project icon to README.
- Updated RSpec helper to verify constant names.
- Updated to Code Quality 4.0.0.
- Updated to Rubocop 0.67.0.
- Updated to Ruby 2.6.3.

# 6.2.0 (2019-04-01)

- Fixed Rubocop Style/MethodCallWithArgsParentheses issues.
- Updated to Ruby 2.6.2.
- Removed RSpec standard output/error suppression.

# 6.1.0 (2019-02-01)

- Updated README to reference updated Runcom documentation.
- Updated to Gemsmith 13.0.0.
- Updated to Git Cop 3.0.0.
- Updated to Rubocop 0.63.0.
- Updated to Ruby 2.6.1.

# 6.0.0 (2019-01-01)

- Fixed Circle CI cache for Ruby version.
- Fixed Layout/EmptyLineAfterGuardClause cop issues.
- Fixed Markdown ordered list numbering.
- Fixed Rubocop RSpec/NamedSubject issues.
- Fixed use of Reek's PrimaDonnaMethod check.
- Added Circle CI Bundler cache.
- Added Rubocop RSpec gem. 5 days ago.
- Updated Circle CI Code Climate test reporting.
- Updated Semantic Versioning links to be HTTPS.
- Updated to Contributor Covenant Code of Conduct 1.4.1.
- Updated to RSpec 3.8.0.
- Updated to Reek 5.0.
- Updated to Rubocop 0.62.0.
- Updated to Ruby 2.6.0.
- Updated to Runcom 4.0.0.
- Removed Rubocop Lint/Void CheckForMethodsWithNoSideEffects check.

# 5.2.0 (2018-05-01)

- Added Runcom examples for project specific usage.
- Updated project changes to use semantic versions.
- Updated to Gemsmith 12.0.0.
- Updated to Git Cop 2.2.0.
- Updated to Runcom 3.1.0.

# 5.1.0 (2018-04-01)

- Fixed gemspec issues with missing gem signing key/certificate.
- Added CLI example usage documentation.
- Added Ruby 2.3.0/2.5.0 String immutable/mutable method documentation.
- Added gemspec metadata for source, changes, and issue tracker URLs.
- Updated gem dependencies.
- Updated to Circle CI 2.0.0 configuration.
- Updated to Rubocop 0.53.0.
- Updated to Ruby 2.5.1.
- Updated to Runcom 3.0.0.
- Removed Circle CI Bundler cache.
- Removed Gemnasium support.
- Refactored temp dir shared context as a pathname.

# 5.0.2 (2018-01-06)

- Fixed CLI `--add` and `--remove` option defaults.
- Fixed short option for `--includes` options.
- Removed Patreon badge from README.

# 5.0.1 (2018-01-01)

- Updated to Gemsmith 11.0.0.

# 5.0.0 (2018-01-01)

- Updated Code Climate badges.
- Updated Code Climate configuration to Version 2.0.0.
- Updated to Ruby 2.4.3.
- Updated to Rubocop 0.52.0.
- Updated to Ruby 2.5.0.
- Removed documentation for secure installs.
- Removed black/white lists (use include/exclude lists instead).
- Updated to Apache 2.0 license.
- Refactored code to use Ruby 2.5.0 `Array#append` syntax.

# 4.3.1 (2017-11-19)

- Updated to Git Cop 1.7.0.
- Updated to Rake 12.3.0.

# 4.3.0 (2017-10-29)

- Added Bundler Audit gem.
- Updated to Rubocop 0.50.0.
- Updated to Rubocop 0.51.0.
- Updated to Ruby 2.4.2.
- Removed Pry State gem.

# 4.2.0 (2017-08-20)

- Added dynamic formatting of RSpec output.
- Updated to Gemsmith 10.2.0.
- Updated to Runcom 1.3.0.

# 4.1.0 (2017-07-16)

- Added Git Cop code quality task.
- Updated CONTRIBUTING documentation.
- Updated GitHub templates.
- Updated README headers.
- Updated command line usage in CLI specs.
- Updated gem dependencies.
- Updated to Awesome Print 1.8.0.
- Updated to Gemsmith 10.0.0.
- Removed Thor+ gem.
- Refactored CLI version/help specs.

# 4.0.0 (2017-06-17)

- Fixed Reek DuplicateMethodCall issue.
- Fixed reading of lines within writer.
- Added Circle CI support.
- Added executable permission to Ruby script fixtures.
- Added runner.
- Updated README usage configuration documenation.
- Updated to Rubocop 0.49.0.
- Updated to Runcom 1.1.0.
- Removed Travis CI support.
- Refactored CLI to use runner.
- Refactored Reek issues.

# 3.1.0 (2017-05-06)

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

# 3.0.0 (2017-01-22)

- Updated Rubocop Metrics/LineLength to 100 characters.
- Updated Rubocop Metrics/ParameterLists max to three.
- Updated Travis CI configuration to use latest RubyGems version.
- Updated gemspec to require Ruby 2.4.0 or higher.
- Updated to Rubocop 0.47.
- Updated to Ruby 2.4.0.
- Removed Rubocop Style/Documentation check.

# 2.2.0 (2016-12-18)

- Fixed Rakefile support for RSpec, Reek, Rubocop, and SCSS Lint.
- Added `Gemfile.lock` to `.gitignore`.
- Updated Travis CI configuration to use defaults.
- Updated gem dependencies.
- Updated to Gemsmith 8.2.x.
- Updated to Rake 12.x.x.
- Updated to Rubocop 0.46.x.
- Updated to Ruby 2.3.2.
- Updated to Ruby 2.3.3.

# 2.1.1 (2016-11-13)

- Fixed gem requirements order.

# 2.1.0 (2016-11-13)

- Fixed Ruby pragma.
- Added Code Climate engine support.
- Added Reek support.
- Updated `--config` command to use computed path.
- Updated to Code Climate Test Reporter 1.0.0.
- Updated to Gemsmith 8.0.0.
- Removed CLI defaults (using configuration instead).
- Refactored source requirements.

# 2.0.0 (2016-11-05)

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

# 1.3.0 (2016-06-16)

- Fixed CLI help documentation.
- Fixed CLI invalid path error message.
- Added README documentation for available pragma comments.
- Updated README documentation (minor tweaks and clarifications).
- Updated to Gemsmith 7.7.0.
- Updated to Ruby 2.3.1.

# 1.2.0 (2016-04-24)

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

# 1.1.0 (2016-01-20)

- Fixed gem secure install issues.

# 1.0.0 (2016-01-18)

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

# 0.1.0 (2015-12-26)

- Initial version.
