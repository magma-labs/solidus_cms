# frozen_string_literal: true

module ComponentsHelper
  extend ActiveSupport::Concern

  def header_logo
    return tag.h1(store_logo_link, class: 'header__logo') if
        current_page?(main_app.root_path)

    store_logo_link
  end

  def store_logo_link
    link_to main_app.root_path do
      image_tag(current_store.logo.url, class: 'img-logo', alt: current_store.name)
    end
  end

  def custom_seo_url(taxon)
    main_app.categories_path(taxon)
  end

  def brands_title
    TaxonomiesService.brands.root.name
  end

  def categories_title
    TaxonomiesService.categories.root.name
  end

  # Acts as a thin wrapper for image_tag and generates an srcset attribute for regular image
  # tags for usage with responsive images polyfills like picturefill.js, supports asset
  # pipeline path helpers.
  #
  # image_set_tag 'pic_1980.jpg',
  #     { 'pic_640.jpg' => '640w', 'pic_1024.jpg' => '1024w', 'pic_1980.jpg' => '1980w' },
  #     sizes: '100vw', class: 'my-image'
  #
  # => <img src="/assets/ants_1980.jpg"
  #     srcset="/assets/pic_640.jpg 640w,
  #             /assets/pic_1024.jpg 1024w,
  #             /assets/pic_1980.jpg 1980w"
  #     sizes="100vw" class="my-image">
  #
  def image_set_tag(source, srcset = {}, options = {})
    srcset = srcset.map { |src, size| "#{path_to_image(src)} #{size}" }.join(', ')
    image_tag(source, options.merge(srcset: srcset))
  end

  def header_ribbon_message
    current_store.ribbon
  end

  def show_social_media_login?
    !spree_current_user ||
      (!spree_current_user.user_authentications &&
        Spree::AuthenticationMethod.active_authentication_methods?)
  end

  def discount_percentage(object)
    (100 - (object.price.to_d * 100 / object.original_price.to_d).floor)
  end

  def footer_element_for(store, &block)
    style = ''
    if store.footer_background.presence
      style = "background-image: url('#{store.footer_background.url(:large)}')"
    end

    tag.footer(class: 'store-footer', style: style, &block)
  end

  def google_maps_script_url
    'https://maps.googleapis.com/maps/api/js' \
      "?key=#{ENV['GOOGLE_MAPS_API_KEY']}" \
      '&libraries=places' \
      '&callback=mapsScriptCallback' \
      "&language=#{I18n.locale}"
  end

  def mega_menu_taxonomies
    Spree::Taxonomy.shown_in_mega_menu
  end

  def google_maps_frame(payload:)
    'https://www.google.com/maps/embed/v1/place'\
      "?key=#{ENV['GOOGLE_MAPS_API_KEY']}" \
      "&q=#{JSON.parse(payload)['formatted_address']}"
  end

  def available_text_colors
    [
      %w[White text-white],
      %w[Dark text-dark],
      %w[Primary text-primary],
      %w[Secondary text-secondary]
    ]
  end

  def available_button_colors
    [
      %w[Link btn-link],
      %w[Light btn-light],
      %w[Dark btn-dark],
      %w[Primary btn-primary],
      %w[Secondary btn-secondary],
      %w[Success btn-success],
      %w[Info btn-info]
    ]
  end

  def text_alignments
    [
      %w[Justify text-justify],
      %w[Center text-center],
      %w[Left text-left],
      %w[Right text-right]
    ]
  end

  def product_result_options
    [
      ['New Arrivals', 'new_arrivals'],
      %w[Recommendations recommendations],
      ['Most Visited', 'most_visited'],
      ['On sale', 'on_sale']
    ]
  end

  def vertical_alignment_options
    [
      %w[Start align-items-start],
      %w[End align-items-end],
      %w[Center align-items-center]
    ]
  end

  def horizontal_alignment_options
    [
      %w[Left justify-content-start],
      %w[Right justify-content-end],
      %w[Center justify-content-center]
    ]
  end
end
