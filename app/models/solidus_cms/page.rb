# frozen_string_literal: true

module SolidusCms
  class Page < SolidusCms::ApplicationRecord
    include Discard::Model
    default_scope -> { kept }

    self.table_name = "solidus_cms_pages"

    has_many :components_pages, class_name: 'SolidusCms::ComponentsPage', dependent: :destroy
    has_many :components, class_name: 'SolidusCms::Component', through: :components_pages

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
