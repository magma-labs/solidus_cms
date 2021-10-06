# frozen_string_literal: true

module Cms
  class PagesController < Spree::StoreController
    layout 'custom_pages'

    def show
      @page = ::Cms::Page.active.find_by(path: request.path_info)
    end

    def preview
      authorize! :manage, ::Cms::Page
      @page = ::Cms::Page.find_by(path: params[:path])
      render :show
    end
  end
end
