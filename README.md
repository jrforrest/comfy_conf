# ComfyConf

Provides a basic specification and validation layer for YAML configs.

### Install

`gem install comfy_conf`

### Use

```ruby
  require 'comfy_conf'

  conf = ComfyConf::Parser.new('./config.yml') do
    prop :name, type: String, required: true
    prop :age, type: Numeric, required: false

    config :nested_options, required: false do
      prop :nested_option, required: true, type: String
    end
  end

  begin
    $config = conf.data
  rescue ComfyConf::Error => e
    STDERR.puts(e.message)
    exit 1
  end
```

### Status

This is extracted from some ruby scripts I use for some basic system
admin tasks.  I don't expect to add much to it but if bugs crop up I'll
address them.

As reflected by the version number, this lib is beta-quality at best.  That
shouldn't matter too much for basic config loading but don't use this
anywhere too critical.

### Contribute

Just fork and PR.

### LICENSE

MIT