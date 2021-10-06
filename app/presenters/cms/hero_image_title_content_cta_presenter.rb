# frozen_string_literal: true

module Cms
  class HeroImageTitleContentCtaPresenter < ComponentsBasePresenter
    def image_styles
      {
          mobile: '420x435#',
          tablet: '740x435#',
          desktop: '1200x430#',
          large: '1920x720#'
      }
    end

    # :reek:DuplicateMethodCall
    def content_alignment_classes
      [
          object.metadata.content_vertical_alignment,
          object.metadata.content_horizontal_alignment,
          object.metadata.text_color
      ].join(' ')
    end
  end
end
