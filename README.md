# Cantook

Facilitates Ruby and Ruby on Rails interaction with the Cantook API

## Installation

Add this line to your application's Gemfile:

``` ruby
gem 'cantook'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install cantook
```

## Usage

### Simulate a sale

``` ruby
base_hash = { 
	username: 'foo', 
	password: 'bar', 
	platform: 'www.cantook.net', 
	organisation_id: 123, 
	sale_state: 'test', 
	format: 'epub', 
	isbn: '123456789asdf',
	currency: 'CAD'
	}

simulate_hash = { 
	cost: '999', 
	protection: 'acs4', 
	country: 'CA'
	}

cantook = Cantook::SimulateASale.new(base_hash)		

if cantook.simulate_a_sale(simulate_hash) 
	puts "success"
else
	puts "failure"
end
```

### Sale of a publication

``` ruby
base_hash = { 
	username: 'foo', 
	password: 'bar', 
	platform: 'www.cantook.net', 
	organisation_id: 123, 
	sale_state 'test', 
	format: 'epub', 
	isbn: '123456789asdf',
	currency: 'CAD'
	}

sale_hash = { 
	cost: '999', 
	customer_id: '123', 
	transaction_id: 'abc', 
	protection: 'acs4',
	country: 'CA' 
	}

cantook = Cantook::SaleOfAPublication.new(base_hash)

if cantook.sale_of_a_publication(sale_hash)
  puts "success"
else
  puts "failure"
end
```

### Download a publication

``` ruby
base_hash = { 
	username: 'foo', 
	password: 'bar', 
	platform: 'www.cantook.net', 
	organisation_id: 123, 
	sale_state: 'test', 
	format: 'epub', 
	isbn: '123456789asdf' 
	}	

download_hash = { 
	customer_id: '123', 
	transaction_id: 'abc', 
	uname: 'Foo Bar' 
	}	

cantook = Cantook::DownloadAPublication.new(base_hash)	

download_link = cantook.download_a_publication(download_hash)

redirect_to download_link
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request