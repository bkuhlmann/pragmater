# frozen_string_literal: true

require "dry/schema"
require "etcher"

Dry::Schema.load_extensions :monads

module Pragmater
  module Configuration
    Contract = Dry::Schema.Params do
      required(:comments).array :string
      required(:patterns).array :string
      required(:root_dir).filled Etcher::Types::Pathname
    end
  end
end
