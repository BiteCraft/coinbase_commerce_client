module CoinbaseCommerceClient
  module APIResources
    class Checkout < Base::APIResource
      extend Base::List
      extend Base::Create
      extend Base::Update

      include Base::Save
      include Base::Delete

      OBJECT_NAME = 'checkout'.freeze
      RESOURCE_PATH = 'checkouts'.freeze
    end
  end
end
