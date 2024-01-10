# frozen_string_literal: true

module SolidusCms
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

    def title_classes
      metadata.values(:section_title_color, :section_title_alignment).join(' ')
    end
  end
end
