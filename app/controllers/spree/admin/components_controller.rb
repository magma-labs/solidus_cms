# frozen_string_literal: true

module Spree
  module Admin
    class ComponentsController < Spree::Admin::ResourceController
      before_action :find_page
      # rubocop:disable Rails/LexicallyScopedActionFilter
      before_action :find_sub_component, only: [:edit]
      # rubocop:enable Rails/LexicallyScopedActionFilter
      helper "components"

      def update
        @object = find_sub_component if params.key?(:component_id) && params.key?(:id)
        super
      end

      def destroy
        @object = find_sub_component if params.key?(:component_id) && params.key?(:id)
        super
      end

      def move_to
        @object = find_sub_component if params.key?(:component_id) && params.key?(:id)
        @object.move_to(params[:position])
        redirect_back fallback_location: location_after_save
      end

      private

      def model_class
        ::Cms::ComponentsPage
      end

      def object_name
        'components_page'
      end

      def collection_url
        edit_admin_custom_page_path(params[:custom_page_id])
      end

      def build_resource
        if params[:component_id]
          find_resource.children.new(page: find_page)
        else
          find_page.components_pages.new
        end
      end

      def find_page
        @page = ::Cms::Page.find(params[:custom_page_id])
      end

      def find_resource
        @component = find_page.components_pages
                              .find_by(id: params[:component_id].presence || params[:id])
      end

      def find_sub_component
        return unless params.key?(:component_id)

        @sub_component = find_resource.children.find(params[:id])
      end

      def permitted_resource_params
        params[:components_page].permit!
      end

      def location_after_save
        if @object.parent
          edit_admin_custom_page_component_component_path(@page, @object.parent, @object)
        else
          admin_custom_page_component_path(@page, @object)
        end
      end

      def location_after_destroy
        admin_custom_page_path(@page)
      end
    end
  end
end
