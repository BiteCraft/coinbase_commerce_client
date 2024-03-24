# frozen_string_literal: true
require "spec_helper"

RSpec.describe CoinbaseCommerceClient::Client do
  after(:each) do
    CoinbaseCommerceClient.configure do |config|
      config.api_key = nil
    end
  end

  describe '#initialize' do
    context 'when api_key is provided' do
      it 'should uses the provided api_key' do
        client = CoinbaseCommerceClient::Client.new(api_key: 'test_api_key')
        expect(client.instance_variable_get(:@api_key)).to eq('test_api_key')
      end
    end

    context 'when api_key is not provided' do
      it 'should uses the globally configured api_key' do
        CoinbaseCommerceClient.configure do |config|
          config.api_key = "global_api_key"
        end

        client = CoinbaseCommerceClient::Client.new

        expect(client.instance_variable_get(:@api_key)).to eq('global_api_key')
      end
    end

    context 'when no api_key is configured' do
      it 'should raise an error' do
        expect { CoinbaseCommerceClient::Client.new }.to raise_error(CoinbaseCommerceClient::Errors::AuthenticationError)
      end
    end
  end
end

RSpec.describe CoinbaseCommerceClient do
  it "has a version number" do
    expect(CoinbaseCommerceClient::VERSION).not_to be nil
  end
end
