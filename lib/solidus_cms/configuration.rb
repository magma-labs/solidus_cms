# frozen_string_literal: true

module SolidusCms
  class Configuration
    attr_accessor :layout, :paperclip_reprocess
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end
