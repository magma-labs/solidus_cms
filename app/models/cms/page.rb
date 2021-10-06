# frozen_string_literal: true

module Cms
  class Page < ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    has_many :components_pages, class_name: 'Cms::ComponentsPage', dependent: :destroy
    has_many :components, class_name: 'Cms::Component', through: :components_pages

    validates :name, presence: true
    validates :path, presence: true, uniqueness: true,
                     format: { with: %r{\A/[/[a-z0-9-]*]*\z},
                               message: I18n.t('custom_pages.pages.slug_error') }
    scope :active, -> { where(active: true) }

    serialize :metadata, JsonSerializer

    def disabled?
      !active
    end
  end
end
