# frozen_string_literal: true

require "cogger"
require "containable"
require "etcher"
require "runcom"
require "spek"

module Pragmater
  # Provides a global gem container for injection into other objects.
  module Container
    extend Containable

    register :registry do
      Etcher::Registry.new(contract: Configuration::Contract, model: Configuration::Model)
                      .add_loader(:yaml, self[:defaults_path])
                      .add_loader(:yaml, self[:xdg_config].active)
    end

    register(:settings) { Etcher.call(self[:registry]).dup }
    register(:specification) { Spek::Loader.call "#{__dir__}/../../pragmater.gemspec" }
    register(:defaults_path) { Pathname(__dir__).join("configuration/defaults.yml") }
    register(:xdg_config) { Runcom::Config.new "pragmater/configuration.yml" }
    register(:logger) { Cogger.new id: :pragmater }
    register :io, STDOUT
  end
end
