# frozen_string_literal: true

module Cms
  class ComponentsPage < ApplicationRecord
    belongs_to :page
    belongs_to :component
    belongs_to :parent, class_name: 'Cms::ComponentsPage', optional: true

    has_many :assets, class_name: 'Cms::Asset', dependent: :destroy, as: :viewable
    has_many :children, class_name: 'Cms::ComponentsPage',
                        foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
    default_scope -> { order(:position) }

    validates :name, presence: true
    delegate :name, to: :component, prefix: true
    delegate :backend_template, :frontend_template, :full_width?, to: :presenter

    serialize :metadata, JsonSerializer

    scope :active, -> { where active: true }
    scope :top_level, -> { where parent_id: nil }

    accepts_nested_attributes_for :assets

    before_create :fill_defaults
    before_create :calculate_position
    before_destroy :update_related_positions

    def presenter
      @presenter ||= "::Cms::#{component_name.camelize}Presenter".constantize.new(self)
    end

    def respond_to_missing?(method, *args)
      metadata.respond_to?(method) || super(method, args)
    end

    def method_missing(method, *args)
      if respond_to_missing?(method)
        metadata.send(method, *args)
      else
        super
      end
    end

    # rubocop:disable Rails/SkipsModelValidations
    def move_to(new_position)
      brothers.where('position >= ?', new_position).update_all('position = position + 1')
      update position: new_position
    end
    # rubocop:enable Rails/SkipsModelValidations

    def brothers
      parent_id ? parent.children.where.not(id: nil) : page.components_pages.top_level
    end

    def find_asset_for_position(position)
      assets.detect do |asset|
        asset.position == position
      end.presence || assets.new(position: position)
    end

    def update_related_positions
      brothers.where('position > ?', position)
          .update_all('position = position - 1') # rubocop:disable Rails/SkipsModelValidations
    end

    private

    def fill_defaults
      self.metadata = presenter.defaults
    end

    def calculate_position
      self.position = (brothers.last&.position.presence || 0) + 1
    end
  end
end
