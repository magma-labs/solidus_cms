# frozen_string_literal: true

module PagesHelper
  def seo_title
    title_string = content_for(:title) || page_title.presence
    if title_string.present?
      return title_string unless Spree::Config[:always_put_site_name_in_title]

      [title_string, current_store.name].join(" #{title_site_name_separator} ")
    else
      current_store.name
    end
  end

  def page_title
    if controller_path.include?('home')
      accurate_title.presence || title_from_locale
    else
      title_from_locale
    end
  end

  def title_from_locale
    t("#{controller_path.tr('/', '.')}.#{action_name}.title", default: '')
  end

  def banner_slides(path)
    Spree::Slide
      .by_paths(PathsService.paths(path))
      .published
  end

  def title_site_name_separator
    SolidusCms::Configuration.try(:title_site_name_separator) || '|'
  end

  def header_ribbon_message
    current_store.ribbon
  end
end
