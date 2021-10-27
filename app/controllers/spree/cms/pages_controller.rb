# frozen_string_literal: true

module Spree
  module Cms
    class PagesController < ::Spree::StoreController
      def show
        @page = ::Cms::Page.active.find_by(path: request.path_info)
        render_with_layout :show
      end

      def preview
        authorize! :manage, ::Cms::Page
        @page = ::Cms::Page.find_by(path: params[:path])
        render_with_layout :show
      end

      private

      def custom_layout
        @page.layout || SolidusCms.configuration.layout
      end

      def render_with_layout(action)
        if custom_layout.present?
          render action, layout: custom_layout
        else
          render action
        end
      end
    end
  end
end
