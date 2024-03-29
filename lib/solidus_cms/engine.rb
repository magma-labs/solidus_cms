# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusCms
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_cms'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.assets.precompile += %w(spree/solidus_cms/*.png)
  end
end
