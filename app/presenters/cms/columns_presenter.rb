# frozen_string_literal: true

module Cms
  class ColumnsPresenter < ComponentsBasePresenter
    def self.component_type
      'container'
    end

    def full_width?
      object.metadata.full_width.eql?('1')
    end

    def height
      object.metadata.height.to_i.positive? ? "#{object.metadata.height}px" : 'auto'
    end

    def title_clasess
      [
          object.metadata.section_title_color
      ].join(' ')
    end
  end
end
