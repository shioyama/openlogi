# Openlogi [![Build Status](https://travis-ci.org/degica/openlogi.svg?branch=master)](https://travis-ci.org/degica/openlogi)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'openlogi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openlogi

## Usage

```ruby
client = Openlogi::Client.new("apikey")
client.get_items
#=> [#<Openlogi::Item:0x005622970fc7c8
#  @barcode="12345111",
#  @code="testsku",
#  @id="OS239-I000001",
#  @name="Test",
#  @price="123">]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/degica/openlogi.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
