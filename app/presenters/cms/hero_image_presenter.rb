# frozen_string_literal: true

module Cms
  class HeroImagePresenter < ComponentsBasePresenter
    def image_styles
      {
        mobile: '420x435#',
        tablet: '740x435#',
        desktop: '1200x430#',
        large: '1920x720#'
      }
    end

    def backend_template
      'image_asset'
    end
  end
end
