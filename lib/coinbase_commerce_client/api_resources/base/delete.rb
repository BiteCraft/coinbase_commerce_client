module CoinbaseCommerceClient
  module APIResources
    module Base
      module Delete
        def delete
          response = @client.request(:delete, "#{self.class::RESOURCE_PATH}/#{self[:id]}")
          initialize_from(response.data)
          self
        end
      end
    end
  end
end