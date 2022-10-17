module CoinbaseCommerceClient
  module APIResources
    module Base
      module Resolve
        def resolve
          resp = @client.request(:post, "#{self.class::RESOURCE_PATH}/#{self[:id]}/resolve", self)
          initialize_from(resp.data)
          self
        end
      end
    end
  end
end