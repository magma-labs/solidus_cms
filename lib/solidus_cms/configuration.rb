# frozen_string_literal: true

module SolidusCms
  class Configuration
    attr_accessor :layout
    attr_accessor :frontend_controller_parent
    attr_accessor :backend_controller_parent
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
