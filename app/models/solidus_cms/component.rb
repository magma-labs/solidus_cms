# frozen_string_literal: true

module SolidusCms
  class Component < SolidusCms::ApplicationRecord
    has_many :component_pages, class_name: 'SolidusCms::ComponentsPage', dependent: :destroy

    validates :name, :component_type, presence: true

    scope :containers, -> { where(component_type: 'container') }
    scope :content, -> { where(component_type: 'content') }
  end
end
