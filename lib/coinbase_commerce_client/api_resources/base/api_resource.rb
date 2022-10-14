module CoinbaseCommerceClient
  module APIResources
    module Base
      class APIResource < APIObject
        class << self
          attr_accessor :client
        end

        @client = nil

        def self.retrieve(id, params = {})
          resp = @client.request(:get, "#{self::RESOURCE_PATH}/#{id}", params)
          Util.convert_to_api_object(resp.data, @client, self)
        end

        def refresh(params = {})
          resp = @client.request(:get, "#{self.class::RESOURCE_PATH}/#{self[:id]}", params)
          initialize_from(resp.data)
        end
      end
    end
  end
end