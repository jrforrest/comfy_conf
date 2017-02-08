module ComfyConf
  class Checker
    def initialize(definition, given_prefix, data)
      @definition, @given_prefix, @data = definition, given_prefix, data
    end
    attr_reader :definition, :data

    def check
      definition.props.each {|p| check_prop(p) }
      definition.configs.each {|c| check_config(c) }
    end

    def prefix
      given_prefix
    end

    private
    attr_reader :given_prefix

    def check_config(config)
      if config.required and not valid_section(config)
        raise MissingSection, "Expected configuration #{prefix} to contain "\
          "section #{config.name} but it does not" \
      end
    end

    def valid_section(config)
      data[config.name] and data[config.name].kind_of?(Hash)
    end

    def check_prop(prop)
      ensure_present(prop) if prop.required
      ensure_type(prop) if data[prop]
    end

    def ensure_type(prop)
      if not data[prop.name].kind_of?(prop.type)
        raise InvalidOption, "Expect type #{prop.type} for "\
          "configuration property #{prefixed_name(prop)}, "\
          "got #{data[prop.name].class}"
      end
    end

    def ensure_present(prop)
      if not data[prop.name]
        raise MissingOption,
          "Configuration property #{prefixed_name(prop)} is required!"
      end
    end

    def prefixed_name(prop)
      if prefix
        "#{prefix}[#{prop.name}]"
      else
        prop.name
      end
    end
  end
end
