# frozen_string_literal: true

# Custom hasn implementaton to simulate keys being properties
class CustomHash
  attr_reader :json

  def initialize(json)
    @json = json
  end

  def respond_to_missing?(method, *_args)
    json.key?(method) || super
  end

  def method_missing(method_name)
    if json.key? method_name
      json[method_name]
    else
      ''
    end
  end
end
