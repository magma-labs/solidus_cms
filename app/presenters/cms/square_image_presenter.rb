# frozen_string_literal: true

module Cms
  class SquareImagePresenter < ComponentsBasePresenter
    def image_styles
      {
        small: '400x400>',
        large: '680x680>'
      }
    end

    def backend_template
      'image_asset_with_positioning'
    end

    def positioning_classes
      [
        object.metadata.vertical_alignment.presence,
        object.metadata.horizontal_alignment.presence
      ].compact.join(' ')
    end
  end
end
