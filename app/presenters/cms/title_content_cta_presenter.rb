# frozen_string_literal: true

module Cms
  class TitleContentCtaPresenter < ComponentsBasePresenter
    def self.content_type
      'component'
    end

    def content_classes
      [
        object.metadata.content_color
      ].join(' ')
    end
  end
end
