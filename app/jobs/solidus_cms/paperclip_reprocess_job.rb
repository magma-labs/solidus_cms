# frozen_string_literal: true

class SolidusCms::PaperclipReprocessJob < ActiveJob::Base
  queue_as :default

  def perform(object, attachment_definition)
    object.send(attachment_definition).reprocess!
  end
end
