# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CoinbaseCommerceClient::APIResources::Charge do
  before :all do
    @client = CoinbaseCommerceClient::Client.new(api_key: 'api_key')
    @api_base = @client.instance_variable_get :@api_uri
  end

  it "making a POST request with parameters should have a body and no query string" do
    stub_request(:post, "#{@api_base}#{CoinbaseCommerceClient::APIResources::Charge::RESOURCE_PATH}")
      .with(body: {:id => "id_value", :code => "code_value"})
      .to_return(body: {data: {id: "id_value", code: "code_value"}}.to_json)
    @client.charge.create(id: "id_value", code: "code_value")
  end

  it "making a GET request with parameters should have a query string and no body" do
    stub_request(:get, "#{@api_base}#{CoinbaseCommerceClient::APIResources::Charge::RESOURCE_PATH}")
      .with(query: {limit: 5}).to_return(body: JSON.generate(data: [mock_list]))
    @client.charge.list(limit: 5)
  end

  it "charge should be canceled successfully " do
    stub_request(:post, "#{@api_base}#{CoinbaseCommerceClient::APIResources::Charge::RESOURCE_PATH}")
      .with(body: {:id => "id_value", :code => "code_value"})
      .to_return(body: {data: {id: "id_value", code: "code_value", timeline: {status: "NEW"}}}.to_json)
    charge = @client.charge.create(id: "id_value", code: "code_value")

    stub_request(:post, "#{@api_base}#{CoinbaseCommerceClient::APIResources::Charge::RESOURCE_PATH}/id_value/cancel")
      .with(body: {})
      .to_return(body: {data: {id: "id_value", code: "code_value", timeline: {status: "CANCELED"}}}.to_json)

    charge.cancel
  end

  it "charge should be resolved successfully " do
    stub_request(:post, "#{@api_base}#{CoinbaseCommerceClient::APIResources::Charge::RESOURCE_PATH}")
      .with(body: {:id => "id_value", :code => "code_value"})
      .to_return(body: {data: {id: "id_value", code: "code_value", timeline: {status: "UNRESOLVED"}}}.to_json)
    charge = @client.charge.create(id: "id_value", code: "code_value")

    stub_request(:post, "#{@api_base}#{CoinbaseCommerceClient::APIResources::Charge::RESOURCE_PATH}/id_value/resolve")
      .with(body: {})
      .to_return(body: {data: {id: "id_value", code: "code_value", timeline: {status: "RESOLVED"}}}.to_json)

    charge.resolve
  end
end