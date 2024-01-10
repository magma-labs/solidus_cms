# frozen_string_literal: true

require "solidus_cms/custom_hash"

module SolidusCms
  class JsonSerializer
    def self.dump(hash)
      hash
    end

    def self.load(hash)
      hash ||= {}
      hash = ActiveSupport::JSON.decode(hash) if hash.is_a?(String)
      hash = hash['json'] if hash.key?('json')
      CustomHash.new(hash.with_indifferent_access)
    end
  end
end
