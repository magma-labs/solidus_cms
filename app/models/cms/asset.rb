# frozen_string_literal: true

module Cms
  class Asset < Spree::Asset
    has_attached_file :attachment,
      styles: ->(attachment) { attachment.instance.image_styles },
      default_url: 'cms/square_image.png',
      url: '/cms/assets/:id/:style/:basename.:extension',
      path: ':rails_root/public/cms/assets/:id/:style/:basename.:extension',
      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }

    validates_attachment :attachment,
      content_type: {
        content_type: %w[image/jpeg image/jpg image/png image/gif]
      }
    validates_attachment(:attachment, presence: true) unless Rails.env.test?

    default_scope -> { order(:position) }

    before_post_process -> { !new_record? }

    after_commit :decide_to_reprocess

    def image_styles
      viewable.presenter.image_styles
    end

    private

    def decide_to_reprocess
      return unless SolidusCms.configuration.paperclip_reprocess
      return unless previous_changes[:attachment_file_size]

      PaperclipReprocessJob.perform_later(self, :attachment)
    end
  end
end
