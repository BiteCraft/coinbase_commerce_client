# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in coinbase_commerce_client.gemspec
gemspec

gem "rake", "~> 13.0"
gem 'faraday', '~> 2.6'
gem 'multipart-post', '~> 2.0'

group :development do
  gem 'pry-byebug', '~> 3.4'
  gem 'rubocop', '~> 1.36', require: false
end

group :test do
  gem 'rspec', '~> 3.0'
  gem 'webmock', '~> 3.18'
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'simplecov-shields-badge', '~> 0.1.0', require: false
end
