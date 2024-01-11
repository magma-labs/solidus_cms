# frozen_string_literal: true

SolidusCms.configure do |config|
  # Adds a new menu item to the Solidus backend
  Spree::Backend::Config.configure do |c|
    c.menu_items << Spree::BackendConfiguration::MenuItem.new(
      [:pages_builder],
      'file',
      url: '/admin/custom_pages',
      condition: -> { can?(:admin, SolidusCms::Page) }
    )
  end

  # Changes the default layout for custom pages
  # config.layout = 'custom_layout'

  # You can override the parent class used by SolidusCms controllers here.
  # This is useful to leverage auth mechanisms, hooks and other behaviors from the main app.
  config.frontend_controller_parent = 'Spree::StoreController'
  config.backend_controller_parent = 'Spree::Admin::ResourceController'
end
