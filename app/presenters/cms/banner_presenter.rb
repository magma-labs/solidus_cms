# frozen_string_literal: true

module Cms
  class BannerPresenter < ComponentsBasePresenter
    def image_styles
      {
        square: '420x630>',
        banner: '1920x720#'
      }
    end

    def background_image
      object.assets.first.attachment
    end

    def cta_image
      object.assets.second.attachment
    end
  end
end
