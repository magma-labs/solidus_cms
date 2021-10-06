# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusCms
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_cms'

    initializer 'solidus_cms.configure_backend' do
      next unless ::Spree::Backend::Config.respond_to?(:menu_items)

      Spree::Backend::Config.configure do |config|
        config.menu_items << config.class::MenuItem.new(
          [:pages_builder],
          'file',
          url: '/admin/custom_pages',
          condition: -> { can?(:admin, ::Cms::Page) })
      end
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
