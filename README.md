# FreezingEmail
[![Build Status](https://travis-ci.org/kaize/freezing_email.png?branch=master)](https://travis-ci.org/kaize/freezing_email)

Saving emais from your Rails app and view it later

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'freezing_email'
```

And then execute:

```
 $ bundle
```

## Usage

*Now supported only rspec integration*

### Rspec integration

Include `FreezingEmail::Rspec` in your rspec test in wich your want to
save email messages. Looks like this:

```ruby
describe UserMailer do
  describe "password_reset" do
    include FreezingEmail::Rspec 
  end
end
```

Then on each test FreezingEmail will save generated deliveres in it's
store folder.

### Configure store path

```ruby
  FreezingEmail::Config[:store_path] = "your_sexy_dir"
```

### Viewing saved emails

To view saved emails, include this lines in your `routes.rb`:

```ruby
  mount FreezingEmail::Web, at: "/freezed_emails", as: :freezing_email
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
