# frozen_string_literal: true

module Spree
  module Admin
    class CustomPagesController < ::Spree::Admin::ResourceController
      destroy.before :track_discard_author

      def index
        @search = model_class.accessible_by(current_ability).ransack(params[:q])
        @custom_pages = @search.result(distinct: true)
          .page(params[:page])
          .per(params[:per_page] || Spree::Config[:orders_per_page])
      end

      private

      def model_class
        ::Cms::Page
      end

      def object_name
        'page'
      end

      def collection_url
        admin_custom_pages_path
      end

      def location_after_save
        request.headers['Referer'].presence || admin_custom_page_path(@object)
      end

      def track_discard_author
        @object.discarded_by = spree_current_user.id
      end
    end
  end
end
