# frozen_string_literal: true

module Cms
  class TaxonPresenter < ComponentsBasePresenter
    def products(_context)
      taxon = Spree::Taxon.find_by permalink: object.metadata.taxon_permalink
      return [] unless taxon

      taxon.products.available.limit(object.metadata.number_of_results)
    end

    def frontend_template
      'products'
    end

    def defaults
      {
          number_of_results: 4
      }
    end
  end
end
