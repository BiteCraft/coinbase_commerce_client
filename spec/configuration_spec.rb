require 'spec_helper'

RSpec.describe CoinbaseCommerceClient::Configuration do
    after(:each) do
        CoinbaseCommerceClient.configure do |config|
            config.api_key = nil;
        end
    end

    describe "#api_key" do
        it 'should allow setting and retrieving the api_key' do
            CoinbaseCommerceClient.configure do |config|
                config.api_key = 'test_api_key'
            end

            expect(CoinbaseCommerceClient.config.api_key).to eq('test_api_key')
        end
    end
end