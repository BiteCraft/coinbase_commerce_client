# frozen_string_literal: true

require_relative "lib/coinbase_commerce_client/version"

Gem::Specification.new do |spec|
  spec.name = "coinbase_commerce_client"
  spec.version = CoinbaseCommerceClient::VERSION
  spec.authors = ["Vinicius Borges"]
  spec.email = ["viniciusborgeis@gmail.com"]

  spec.summary = "Coinbase Commerce integration client for crypto payments"
  spec.description = "Coinbase Commerce integration client for crypto payments"
  spec.homepage = "https://github.com/viniciusborgeis/coinbase_commerce_client"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/viniciusborgeis/coinbase_commerce_client"
  spec.metadata["changelog_uri"] = "https://github.com/viniciusborgeis/coinbase_commerce_client"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency('faraday', '~> 2.6')
  spec.add_dependency('multipart-post', '~> 2.0')

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
