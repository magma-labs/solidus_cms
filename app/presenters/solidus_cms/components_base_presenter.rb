# frozen_string_literal: true

module SolidusCms
  class ComponentsBasePresenter
    attr_reader :object

    delegate :metadata, to: :object
    def initialize(object)
      @object = object
    end

    def name
      raise 'Implement top level in final class'
    end

    def self.component_type
      'content'
    end

    def can_be_parent_of
      raise 'Implement top level in final class'
    end

    def template_name
      @template_name ||= self.class.name.demodulize.underscore.gsub('_presenter', '')
    end

    def backend_template
      template_name
    end

    def frontend_template
      template_name
    end

    def image_styles
      raise 'Implement in final class'
    end

    def full_width?
      false
    end

    def defaults
      {}
    end

    def product_template
      metadata.tile_type == 'horizontal' ? 'product_horizontal_tile' : 'product_tile'
    end

    def title_classes
      metadata.values(:title_color, :title_alignment).join(' ')
    end

    def content_classes
      (%w[my-3] + metadata.values(:content_color, :content_alignment)).join(' ')
    end
  end
end
