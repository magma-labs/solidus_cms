# frozen_string_literal: true

module Spree::SolidusCms
  class PagesController < Spree::StoreController
    def show
      @page = SolidusCms::Page.active.find_by(path: request.path_info)
    end

    def preview
      authorize! :manage, SolidusCms::Page
      @page = SolidusCms::Page.find_by(path: params[:path])
      render :show
    end
  end
end
