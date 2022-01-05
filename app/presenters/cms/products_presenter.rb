# frozen_string_literal: true

module Cms
  class ProductsPresenter < ComponentsBasePresenter
    def products(context)
      send(object.metadata.group_of_products, context)
    end

    def new_arrivals(_context)
      Spree::Product.new_arrivals(object.metadata.number_of_results)
    end

    def recommendations(context)
      recommended_products(context).presence || most_visited_products
    end

    def most_visited(_context)
      most_visited_products
    end

    def recommended_products(context)
      RecommendationsService.new(context.products_visited)
                            .perform(max_amount: object.metadata.number_of_results)
    end

    def most_visited_products
      Spree::Product.most_visited(object.metadata.number_of_results)
    end

    def on_sale(_context)
      Spree::Product.on_sale(object.metadata.number_of_results)
    end

    def defaults
      {
        number_of_results: 4,
        group_of_products: 'new_arrivals'
      }
    end
  end
end
