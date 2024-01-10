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
end
