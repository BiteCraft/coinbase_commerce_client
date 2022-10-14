module CoinbaseCommerceClient
  module APIResources
    module Base
      module List
        def list(params = {})
          resp = @client.request(:get, self::RESOURCE_PATH.to_s, params)
          Util.convert_to_api_object(resp.data, @client, self)
        end

        def auto_paging(params = {}, &blk)
          loop do
            page = list(params)
            last_id = page.data.empty? ? nil : page.data.last.id
            break if last_id.nil?

            params[:starting_after] = last_id
            page.data.each(&blk)
          end
        end
      end
    end
  end
end
