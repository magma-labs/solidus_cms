# frozen_string_literal: true

module SolidusCms
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
    self.table_name_prefix = 'solidus_cms_'
  end
end
