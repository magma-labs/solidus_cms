# frozen_string_literal: true

module Cms
  class Component < ApplicationRecord
    has_many :component_pages, class_name: 'Cms::ComponentsPage', dependent: :destroy

    validates :name, :component_type, presence: true

    scope :containers, -> { where(component_type: 'container') }
    scope :content, -> { where(component_type: 'content') }
  end
end
