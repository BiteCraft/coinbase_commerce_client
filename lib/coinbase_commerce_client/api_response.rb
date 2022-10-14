module CoinbaseCommerceClient
  class CoinbaseCommerceClientResponse
    attr_accessor :data, :http_body, :http_headers, :http_status, :request_id

    # Initializes a CoinbaseCommerceResponse object
    # from a Hash like the kind returned as part of a Faraday exception.
    def self.from_faraday_hash(http_resp)
      resp = CoinbaseCommerceClientResponse.new
      resp.data = JSON.parse(http_resp[:body], symbolize_names: true)
      resp.http_body = http_resp[:body]
      resp.http_headers = http_resp[:headers]
      resp.http_status = http_resp[:status]
      resp.request_id = http_resp[:headers]['x-request-id']
      resp
    end

    # Initializes a CoinbaseCommerceResponse object
    # from a Faraday HTTP response object.
    def self.from_faraday_response(http_resp)
      resp = CoinbaseCommerceClientResponse.new
      resp.data = JSON.parse(http_resp.body, symbolize_names: true)
      resp.http_body = http_resp.body
      resp.http_headers = http_resp.headers
      resp.http_status = http_resp.status
      resp.request_id = http_resp.headers['x-request-id']

      # unpack nested data field if it exist
      resp.data.update(resp.data.delete(:data)) if resp.data.is_a?(Hash) && resp.data.fetch(:data, nil).is_a?(Hash)

      # warn in there warnings in response
      warn(resp.data[:warnings].first.to_s) if resp.data.is_a?(Hash) && resp.data.fetch(:warnings, nil).is_a?(Array)

      resp
    end
  end
end
