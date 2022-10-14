module CoinbaseCommerceClient
  module APIResources
    class Event < Base::APIResource
      extend Base::List

      OBJECT_NAME = 'event'.freeze
      RESOURCE_PATH = 'events'.freeze
    end
  end
end