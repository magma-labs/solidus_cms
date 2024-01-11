# frozen_string_literal: true

module Spree::SolidusCms
  class PagesController < SolidusCms.config.frontend_controller_parent.constantize
    layout SolidusCms.config.layout if SolidusCms.config.layout.present?

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
