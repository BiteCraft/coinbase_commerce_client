<h1 align="center">
  <br>
  <img width="100%" src="https://raw.githubusercontent.com/viniciusborgeis/coinbase_commerce_client/main/assets/banner.png" alt="Coinbase Commerce Client">
  <br>
  Coinbase Commerce Client
  <br>
</h1>

<h4 align="center">A client to handle cryptocurrency payments using <a href="https://commerce.coinbase.com/" target="_blank">Coinbase Commerce</a> platform</h4>

<p align="center">
	<img src="https://badge.fury.io/rb/coinbase_commerce_client.svg" alt="Coverage">
	<img src="https://raw.githubusercontent.com/viniciusborgeis/coinbase_commerce_client/main/badge.svg" alt="Coverage">
    <img src="https://img.shields.io/gem/dt/coinbase_commerce_client.svg?type=total"  alt="Total Downloads">
</p>

<p align="center">
  <a href="#ruby-version">Ruby Versions</a> •
  <a href="#dependencies">Dependencies</a> •
  <a href="#documentation">Docs</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#validating-webhook-signatures">Validating Webhook</a> •
  <a href="#testing-and-contributing">Contributing</a>
</p>
<sub>This gem is completely inspired by official Coinbase gem <a href="https://github.com/coinbase/coinbase-commerce-ruby">coinbase-commerce-ruby</a>, unfortunately the oficial gem actually is deprecated, and my motivation is to continue support for this gem</sub>

## Ruby Version
Ruby [2.3 -> 3.1.2] are supported and tested.

## Dependencies

The following libraries will be installed when you install the client library:
* [faraday](https://github.com/lostisland/faraday)

## Documentation

For more details visit [Coinbase API docs](https://commerce.coinbase.com/docs/api/).

To start using library, you'll need to [create a Coinbase Commmerce account](https://commerce.coinbase.com/signup).
Once you've created your Coinbase Commerce account, create an ``API_KEY`` in Settings.

Next create a ``Client`` object for interacting with the API:
```ruby
require 'coinbase_commerce_client'
API_KEY = "API KEY"
client = CoinbaseCommerceClient::Client.new(api_key: API_KEY)
```

``Client`` contains links to every Ruby Class representations of the API resources
``Checkout, Charge, Invoices, Event``

You can call ``list, auto_paging, create, resolve, cancel, retrieve, modify`` methods from API resource classes

```ruby
#charges
client.charge.list
client.charge.auto_paging
client.charge.create <payload>
charge = client.charge.retrieve <id>
charge.resolve
charge.cancel

#checkout
client.checkout.list
client.checkout.auto_paging
client.checkout.create <payload>
checkout = client.checkout.retrieve <id>
checkout.refresh
checkout.save
checkout.modify <payload>
checkout.delete

#events
client.event.list
client.event.auto_paging
event = client.event.retrieve <id>

```

Each API method returns an ``APIObject`` representing the JSON response from the API, all of the models support hash and JSON representation.\
Also when the response data is parsed into Ruby objects, the appropriate ``APIObject`` subclasses will be used automatically.
All subclasses of ``APIResource`` class support ``refresh`` method. This will update their attributes and all nested data by making a fresh ``GET`` request to the relevant API endpoint.

The client supports handling of common API errors and warnings.
All errors occuring during the interaction with the API will be raised as exceptions.

| Error                    | Status Code |
|--------------------------|-------------|
| APIError                 |      *      |   
| InvalidRequestError      |     400     |   
| ParamRequiredError       |     400     |  
| ValidationError          |     400     |  
| AuthenticationError      |     401     |  
| ResourceNotFoundError    |     404     |
| RateLimitExceededError   |     429     |
| InternalServerError      |     500     |
| ServiceUnavailableError  |     503     |


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coinbase_commerce_client'
```
Then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install coinbase_commerce_client
```

## Usage
* [Checkouts](#checkouts)
* [Charges](#charges)
* [Events](#events)


```ruby
require 'coinbase_commerce_client'
client = CoinbaseCommerceClient::Client.new(api_key: 'your_api_key')
```

### Checkouts
[Checkouts API docs](https://commerce.coinbase.com/docs/api/#checkouts)

#### Retrieve
```ruby
checkout = client.checkout.retrieve <checkout_id>
```

#### Create
```ruby
checkout_info = {
    "name": "The Sovereign Individual",
    "description": "Mastering the Transition to the Information Age",
    "pricing_type": "fixed_price",
    "local_price": {
        "amount": "1.00",
        "currency": "USD"
    },
    "requested_info": ["name", "email"]
}
checkout = client.checkout.create(checkout_info)
# or
checkout = client.checkout.create(:name=>'The Sovereign Individual',
                                  :description=>'Mastering the Transition to the Information Age',
                                  :pricing_type=>'fixed_price',
                                  :local_price=>{
                                          "amount": "100.00",
                                          "currency": "USD"
                                          },
                                  :requested_info=>["name", "email"])                            
```

#### Update
```ruby
checkout = client.checkout.retrieve <checkout_id>
checkout.name = 'new name'
checkout.save
# or
client.checkout.modify(<checkout_id>, "local_price": {
    "amount": "10000.00",
    "currency": "USD"
})
```

#### Delete
```ruby
checkout.delete
```

#### List
```ruby
checkouts = client.checkout.list
```

#### Paging list iterations
```ruby
client.checkout.auto_paging  do |ch|
  puts ch.id
end
```

### Charges
[Charges API docs](https://docs.cloud.coinbase.com/commerce/reference/getcharges)

#### Retrieve
```ruby
charge = client.charge.retrieve <charge_id>
```

#### Create
```ruby
charge_info = {
    "name": "The Sovereign Individual",
    "description": "Mastering the Transition to the Information Age",
    "pricing_type": "fixed_price",
    "local_price": {
        "amount": "1.00",
        "currency": "USD"
    },
    "requested_info": ["name", "email"]
}
charge = client.charge.create(charge_info)
# or
charge = client.charge.create(:name=>'The Sovereign Individual',
                              :description=>'Mastering the Transition to the Information Age',
                              :pricing_type=>'fixed_price',
                              :local_price=>{
                                  "amount": "100.00",
                                  "currency": "USD"
                              })
```

#### List
```ruby
charges_list = client.charge.list
```

#### Paging list iterations
```ruby
client.charge.auto_paging do |charge|
  puts charge.id
end
```

#### Resolve
```ruby
charge = client.charge.retrieve <charge_id>
charge.resolve
```

#### Cancel
```ruby
charge = client.charge.retrieve <charge_id>
charge.cancel
```

## Events
[Events API Docs](https://docs.cloud.coinbase.com/commerce/reference/getevents)

#### Retrieve
```ruby
event = client.event.retrieve <event_id>
```

#### List
```ruby
events = client.event.list
```

#### Paging list iterations
```ruby
client.event.auto_paging do |event|
  puts event.id
end
```

## Validating webhook signatures
You should verify the webhook signatures using our library.
To perform the verification you'll need to provide the event data, a webhook signature from the request header, and the endpoint’s secret.
In case of an invalid request signature or request payload, you will receive an appropriate error message.

```ruby
WEBHOOK_SECRET = 'your_webhook_secret'
# Using Sinatra
post '/webhooks' do
  request_payload = request.body.read
  sig_header = request.env['HTTP_X_CC_WEBHOOK_SIGNATURE']
  begin
    event = CoinbaseCommerceClient::Webhook.construct_event(request_payload, sig_header, WEBHOOK_SECRET)
    # event handle
    puts "Received event id=#{event.id}, type=#{event.type}"
    status 200
    # errors handle
  rescue JSON::ParserError => e
    puts "json parse error"
    status 400
    return
  rescue CoinbaseCommerceClient::Errors::SignatureVerificationError => e
    puts "signature verification error"
    status 400
    return
  rescue CoinbaseCommerceClient::Errors::WebhookInvalidPayload => e
    puts "missing request or headers data"
    status 400
    return
  end
end
```

### Testing and Contributing
Any and all contributions are welcome! The process is simple: fork this repo, make your changes, add tests, run the test suite, and submit a pull request. Tests are run via rspec. To run the tests, clone the repository and then:

    # Install the requirements
    gem install coinbase_commerce_client
    rspec spec
    
    # or via Bundle
    bundle install
    bundle exec rspec spec