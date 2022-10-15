module CoinbaseCommerceClient
  module APIResources
    module Base
      module Cancel
        def cancel
          resp = @client.request(:post, "#{self.class::RESOURCE_PATH}/#{self[:id]}/cancel", self)
          initialize_from(resp.data)
          self
        end
      end
    end
  end
end