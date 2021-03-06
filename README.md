# PCD8544 LCD controller Ruby gem for Raspberry PI

The PCD8544 is a low power CMOS LCD controller/driver, designed to drive a graphic display of 48 rows and 84 columns. It's cheap and widely used with embedded systems.

Datasheet for PCD8544 may be found [here](https://www.sparkfun.com/datasheets/LCD/Monochrome/Nokia5110.pdf)

## Installation

Install the gem:

```bash
$ gem install pcd8544
```

## Usage

Initialize the class for your screen:

```ruby
screen = Pcd8544::Screen.new
```

The default pins are

| PIN Name | GPIO |
|----------|------|
| SCE      |  8   |
| RESET    |  24  |
| DC       |  23  |
| SDIN     |  10  |
| SCLK     |  11  |
| LED      |  18  |

You can override pins at constructor:

```ruby
screen = Pcd8544::Screen.new(pins: { SCE: 5, RESET: 6 })
```

### Backlight

To control the backlight you can use

```ruby
screen.backlight(true) # turn on
```

or

```ruby
screen.backlight(false) # turn off
```

To get current state you can use


```ruby
screen.backlight?
```

### Instruction Mode

PCD8544 controller has two instruction modes: COMMAND and DATA, indicated by DC pin. To switch between the modes, you can use

```ruby
screen.ensure_command_mode
```

or

```ruby
screen.ensure_data_mode
```

You can also check the current mode:

```ruby
screen.command_mode?
```

or

```ruby
screen.data_mode?
```

### Function Set

The controller has two different function set for COMMAND mode: BASIC and EXTENDED. The same way, you can switch them using:

```ruby
screen.ensure_basic_set
screen.ensure_extended_set
```

And to get current function set:

```ruby
screen.basic_set?
screen.extended_set?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pcd8544/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
