module CoinbaseCommerceClient
  module APIResources
    class Charge < Base::APIResource
      extend Base::List
      extend Base::Create

      include Base::Cancel
      include Base::Resolve

      OBJECT_NAME = 'charge'.freeze
      RESOURCE_PATH = 'charges'.freeze
    end
  end
end
