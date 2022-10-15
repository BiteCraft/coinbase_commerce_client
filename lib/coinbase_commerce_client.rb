# frozen_string_literal: true

# general
require "json"
require "uri"
require "openssl"
require "faraday"

# version
require "coinbase_commerce_client/version"

# client
require "coinbase_commerce_client/client"

# api response and errors
require "coinbase_commerce_client/api_errors"
require "coinbase_commerce_client/api_response"

# api base object
require "coinbase_commerce_client/api_resources/base/api_object"

# api resource base model
require "coinbase_commerce_client/api_resources/base/api_resource"

# api base operations
require "coinbase_commerce_client/api_resources/base/create"
require "coinbase_commerce_client/api_resources/base/update"
require "coinbase_commerce_client/api_resources/base/cancel"
require "coinbase_commerce_client/api_resources/base/save"
require "coinbase_commerce_client/api_resources/base/list"
require "coinbase_commerce_client/api_resources/base/delete"

# api resources
require "coinbase_commerce_client/api_resources/checkout"
require "coinbase_commerce_client/api_resources/charge"
require "coinbase_commerce_client/api_resources/event"

# webhooks
require "coinbase_commerce_client/webhooks"

# utils
require "coinbase_commerce_client/util"


module CoinbaseCommerceClient
end
