# Rails Typed Settings

Implements cached database stored settings for rails.
Settings are typed. You can't set a boolean setting to an integer.

## Setup

Add to your Gemfile:

```ruby
gem "rails_typed_settings"
```

Generate migration:

```bash
$ rails g rails_typed_settings:install
```

Migrate your database:

```bash
$ rake db:migrate
```

## Usage

Add a config/initializers/settings.rb file with contents:

```ruby
class Settings < RailsTypedSettings::Base
  setting :sale, :boolean, :default => false
  setting :sale_discount, :float, :default => 0.3
  setting :sale_name, :string
end
```

Reading a setting:

```ruby
Settings[:sale]
```

Writing a setting:

```ruby
Settings[:sale] = true
```

Get list of all settings

```ruby
Settings.keys   # [:sale, :sale_discount...]
```


This project rocks and uses MIT-LICENSE.