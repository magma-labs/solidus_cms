# frozen_string_literal: true

module Spree::SolidusCms
  class PagesController < SolidusCms.config.frontend_controller_parent.constantize
    layout SolidusCms.config.layout if SolidusCms.config.layout.present?

    def show
      @page = model_class.active.find_by!(path: request.path_info)
    end

    def preview
      authorize! :manage, model_class
      @page = model_class.find_by(path: params[:path])
      render :show
    end

    private

    def model_class
      SolidusCms::Page
    end
  end
end
