module CoinbaseCommerceClient
  module APIResources
    module Base
      module Save
        def save
          values = serialize_params(self)
          values.delete(:id)
          resp = @client.request(:put, "#{self.class::RESOURCE_PATH}/#{self[:id]}", self)
          initialize_from(resp.data)
          self
        end
      end
    end
  end
end