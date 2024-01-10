# frozen_string_literal: true

module Spree::SolidusCms
  module Admin
    class CustomPagesController < ::Spree::Admin::ResourceController
      destroy.before :track_discard_author

      private

      def model_class
        SolidusCms::Page
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
