# Exonio

This gem brings some useful Excel formulas to Ruby. For now, it just has
financial formulas, but could have more (like statistical formulas) in the future.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'exonio'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install exonio

## Usage

To use Exonio you just have to call the method you like to use. Example:

```ruby
 Exonio.pmt(0.075 / 12, 12 * 15, 200_000) # ==> -1854.02
```

## Contributing
 1. Fork the repository
 2. Create a branch
 3. Hack hack hack...
 4. Create a spec
 5. Open a Pull Request ;)

## License

Exonio is released under the MIT License.

