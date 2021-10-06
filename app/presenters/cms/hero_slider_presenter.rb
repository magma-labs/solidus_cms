# frozen_string_literal: true

module Cms
  class HeroSliderPresenter < ComponentsBasePresenter
    def self.component_type
      'container'
    end

    def image_styles
      {
          mobile: '700x400##',
          tablet: '1200x300#',
          large: '1920x480#'
      }
    end

    def full_width?
      object.metadata.full_width.eql?('1')
    end

    def defaults
      {
          height: 400,
          full_width: true
      }
    end
  end
end
