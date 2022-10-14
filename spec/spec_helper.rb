# frozen_string_literal: true

require 'bundler/setup'
require 'support/simplecov_config'
require 'pry-byebug'
require 'webmock/rspec'

Bundler.setup()
require 'coinbase_commerce_client'

def mock_item
  {:id => "val", :key => "val"}
end

def mock_list
  {
    :pagination => mock_item,
    :data => [mock_item, mock_item]
  }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
