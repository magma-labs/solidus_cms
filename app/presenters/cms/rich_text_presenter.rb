# frozen_string_literal: true

module Cms
  class RichTextPresenter < ComponentsBasePresenter
    def content_classes
      [
          object.metadata.body_color
      ].join(' ')
    end
  end
end
