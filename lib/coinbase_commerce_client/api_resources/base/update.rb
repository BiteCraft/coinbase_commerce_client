module CoinbaseCommerceClient
  module APIResources
    module Base
      module Update
        def modify(id, params={})
          resp = @client.request(:put, "#{self::RESOURCE_PATH}/#{id}", params)
          Util.convert_to_api_object(resp.data, @client, self)
        end
      end
    end
  end
end